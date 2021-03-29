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
import 'package:studenthub2/ui/auth/reset_pass/model/reset_pass_model.dart';

class PinController {
  StreamController<ErrorAnimationType> _streamController;
  BuildContext _context;
  RegisterModel registerModel;
  StudentRegModel studentRegModel;
  PassResetModel _passResetModel;

  PinController(BuildContext context,
      StreamController<ErrorAnimationType> streamController,
      {PassResetModel passResetModel}) {
    this._streamController = streamController;
    this._context = context;
    this._passResetModel = passResetModel;

    if (_passResetModel == null) {
      studentRegModel = SPData.spData.getStudentRegInfo();
      registerModel = RegisterModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(studentRegModel.data)));
      print(registerModel.toJson());
    }
  }
  Future<void> checkPin(String pin) async {
    if (_passResetModel != null) {
      _pinForReset(pin);
    } else {
      _pinForNew(pin);
    }
  }

  _pinForReset(String pin) async {
    if (pin.length != _passResetModel.code.length) {
      _streamController.add(ErrorAnimationType.shake);
    } else {
      if (pin == _passResetModel.code) {
        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (_) => Password(
              passResetModel: _passResetModel,
            ),
          ),
        );
      } else {
        _streamController.add(ErrorAnimationType.shake);
      }
    }
  }

  _pinForNew(String pin) async {
    if (pin.length != studentRegModel.otp.length) {
      _streamController.add(ErrorAnimationType.shake);
    } else {
      print({"StudentId ": registerModel.studentId, "Code": pin});
      String data = DataProcess.getEncryptedData(
          jsonEncode({"StudentId ": registerModel.studentId, "Code": pin}));
      print(data);
      Response response = await ApiService.postMethod(
          "https://studenthub.smartcampus.com.my/api/Home/StudentMobileApi/VerifyOTP?input=$data",
          allowFullUrl: false);
      DataModel dataModel = DataModel.fromJson(response.data);
      if (dataModel.hasError) {
        _streamController.add(ErrorAnimationType.shake);
        showMessage(dataModel.errors.first);
        return;
      } else {
        if (dataModel.dataExtra != null) {
          print(DataProcess.getDecryptedData(dataModel.dataExtra));
          print(DataProcess.getDecryptedData(dataModel.data));
        }
        studentRegModel.verified = true;
        SPData.spData.setStudentRegInfo(studentRegModel);
        Navigator.push(_context, MaterialPageRoute(builder: (_) => Password()));
      }
    }
  }

  Future<String> resendCode() async {
    String s = DataProcess.getEncryptedData(registerModel.emailAddress);
    print(
        "https://studenthub.smartcampus.com.my/api/Home/StudentMobileApi/ResendOTP?input=$s");
    Response response = await ApiService.postMethod(
        "https://studenthub.smartcampus.com.my/api/Home/StudentMobileApi/ResendOTP?input=$s",
        allowFullUrl: false);
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
      return null;
    } else {
      showMessage("OTP sent!");
      print(DataProcess.getDecryptedData(dataModel.data));
      return DataProcess.getDecryptedData(dataModel.data);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
