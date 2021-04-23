import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/profile/model/profile_model.dart';
import 'package:studenthub2/ui/profile/view/upload_dialog.dart';

class ProfileController {
  BuildContext _context;
  ProfileController(BuildContext context) {
    this._context = context;
  }
  static getProfile() async {
    Response response = await ApiService.getMethod(
        "/StudentProfileMobileApi/GetStudentProfile");
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
    } else {
      ProfileModel profileModel = ProfileModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(dataModel.data)));
      InstitutionDetails institutionDetails =
          InstitutionDetails.fromJson(dataModel.dataExtra);
      profileModel.institutionDetails = institutionDetails;
      setProfile = profileModel;
    }
  }

  Future<File> getImage() async {
    ImageSource imageSource = await _showPicker();
    if (imageSource == null) {
      showMessage("No image selected!");
      return null;
    }
    File image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      Response response = await showDialog(
          context: _context,
          builder: (BuildContext context) => ImageUploadDialog(
                image: image,
              ),
          barrierDismissible: false);
      if (response == null) {
        showMessage("Upload cancel!");
        return null;
      } else {
        DataModel dataModel = DataModel.fromJson(response.data);
        if (dataModel.hasError) {
          print(dataModel.errors);
          showMessage(dataModel.errors.first);
          return null;
        } else {
          print(dataModel.dataExtra);
          String url = dataModel.dataExtra['Image'];
          await CachedNetworkImage.evictFromCache(ApiService.baseUrl+url);
          profileModel.institutionDetails.image = url;
          return image;
        }
      }
    } else {
      showMessage("No image selected!");
      return null;
    }
  }

  Future<ImageSource> _showPicker() async {
    return await showModalBottomSheet(
        context: _context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        Navigator.of(_context).pop(ImageSource.gallery);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(_context).pop(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
