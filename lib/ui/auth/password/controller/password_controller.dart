import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/model/student_reg.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:studenthub2/ui/auth/register/model/register_model.dart';

class PasswordController {
  BuildContext _context;

  PasswordController(BuildContext context) {
    this._context = context;
  }

  setInitPassword(String password) async {
    StudentRegModel studentRegModel = SPData.spData.getStudentRegInfo();
    RegisterModel registerModel = RegisterModel.fromJson(
        jsonDecode(DataProcess.getDecryptedData(studentRegModel.data)));
    Map<String, dynamic> map = {
      "StudentId": registerModel.studentId,
      "Password": password
    };
    Response response = await ApiService.postMethod(
        "/StudentMobileApi/SetUpdatePassword?input=${DataProcess.getEncryptedData(jsonEncode(map))}");
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
    } else {
      showMessage("Setup complete");
      Navigator.pushAndRemoveUntil(_context,
          MaterialPageRoute(builder: (_) => Login()), (route) => false);
    }
  }
}
