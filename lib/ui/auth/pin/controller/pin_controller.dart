import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/model/student_reg.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/password/view/password.dart';
import 'package:studenthub2/ui/auth/register/model/register_model.dart';

class PinController {
  StreamController<ErrorAnimationType> _streamController;
  BuildContext _context;
  PinController(BuildContext context,
      StreamController<ErrorAnimationType> streamController) {
    this._streamController = streamController;
    this._context = context;
  }
  void checkPin(String pin) async {
    if (pin.length != 6) {
      _streamController.add(ErrorAnimationType.shake);
    } else {
      StudentRegModel studentRegModel = SPData.spData.getStudentRegInfo();
      RegisterModel registerModel = RegisterModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(studentRegModel.data)));
      String data = DataProcess.getEncryptedData(
          jsonEncode({"StudentId ": registerModel.studentId, "Code": pin}));
      Response response = await ApiService.postMethod(
          "/StudentMobileApi/VerifyOTP?input=$data");
      DataModel dataModel = DataModel.fromJson(response.data);
      if (dataModel.hasError) {
        showMessage(dataModel.errors.first);
        return;
      } else {
        studentRegModel.verified = true;
        SPData.spData.setStudentRegInfo(studentRegModel);
        Navigator.push(_context, MaterialPageRoute(builder: (_)=>Password()));
      }
    }
  }

  void dispose() {
    _streamController.close();
  }
}
