import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/profile/model/profile_model.dart';

class ProfileController {
  // BuildContext _context;
  // ProfileController(BuildContext context){
  //   this._context = context;
  // }
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


  Future getImage(ImageSource imageSource) async {
    File image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      showMessage("No image selected!");
    }
  }
}
