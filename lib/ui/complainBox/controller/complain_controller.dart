import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/complainBox/model/complain_model.dart';

class ComplainController {
  ComplaintCategoryModel categoryModel = ComplaintCategoryModel();
  ComplaintLevelCategory? complaintLevelCategory;
  AdminComplaintCategory? adminComplaintCategory;
  bool agree = true;
  ValueNotifier<File?> imageNotifier = ValueNotifier(null);
  File? image;
  Future<bool> getComplainCategory() async {
    print("enter");
    Response response = await ApiService.getMethod(
      "/ComplaintMobileApi/GetComplaintCategoryLevel",
    );
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError ?? false) {
      print(dataModel.errors!.first);
      showMessage(dataModel.errors!.first);
      throw Exception(dataModel.errors!.first);
    } else {
      try {
        categoryModel = ComplaintCategoryModel.fromJson(
          jsonDecode(
            DataProcess.getDecryptedData(dataModel.dataExtra!),
          ),
        );
        return true;
      } catch (e) {
        throw e;
      }
    }
  }

  Widget getDropDown<T>(
      {Key? key,
      required List<T> list,
      required String Function(T) getValue,
      required FormFieldValidator validator,
      required void Function(T?) onChange}) {
    print("=========Called=========");
    return FormField<int>(
      key: key,
      validator: validator,
      builder: (FormFieldState<int> state) {
        return InputDecorator(
          decoration: InputDecoration(
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
              hintText: 'Please select expense',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          isEmpty: state.value == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: state.value,
              isDense: true,
              onChanged: (int? newValue) {
                state.didChange(newValue);
                onChange(list[newValue!]);
              },
              items: List<int>.generate(list.length, (index) => index)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(getValue(list[value])),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Future<File?> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      imageNotifier.value = image;
    } else {
      showMessage("No image selected!");
      return null;
    }
  }

  Future<bool> submitComplain(String details) async {
    DateFormat _dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    Map<String, dynamic> map = {
      "ComplaintLevelId": complaintLevelCategory!.id,
      "ComplaintCategoryId": adminComplaintCategory!.id,
      "Description": details,
      "Date": _dateFormat.format(DateTime.now()),
      "EndDateTime": _dateFormat.format(DateTime.now()),
      "IsDeclared": "True"
    };
    Response response = await ApiService.postMethod(
        "/ComplaintMobileApi/SaveComplaint?input=${DataProcess.getEncryptedData(jsonEncode(map))}");
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError ?? false) {
      print(dataModel.errors!.first);
      showMessage(dataModel.errors!.first);
      throw Exception(dataModel.errors!.first);
    } else {
      int id = jsonDecode(DataProcess.getDecryptedData(dataModel.data!))['Id'];
      print(id);
      if(image!=null){
        Response photoResponse = await _uploadPhoto(id);
        DataModel imageData = DataModel.fromJson(photoResponse.data);
        if (imageData.hasError ?? false) {
          print(imageData.errors!.first);
          showMessage(imageData.errors!.first);
          throw Exception(imageData.errors!.first);
        } else {
          print(imageData.dataExtra);
          showMessage("Complain Submitted!");
          return true;
        }
      }else{
        showMessage("Complain Submitted!");
        return true;
      }
    }
  }

  Future<Response> _uploadPhoto(int id) async {
    Dio dio = new Dio();
    dio.options.headers['Authorization'] = 'Bearer ${loginInfo!.token}';
    dio.options.contentType = "multipart/form-data";
    String name = image!.path.split('/').last;
    print(name);
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          image!.path,
          filename: name,
        ),
        "Id": id
      });

      Response response = await dio.post(
          ApiService.baseUrl + "/api/Home/ComplaintMobileApi/UploadPhoto",
          data: formData);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
      } else {
        print(e.message);
      }
      throw e;
    }
  }
}
