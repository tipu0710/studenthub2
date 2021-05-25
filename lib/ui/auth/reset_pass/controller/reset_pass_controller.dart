import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/auth/pin/view/pin.dart';
import 'package:studenthub2/ui/auth/reset_pass/model/reset_pass_model.dart';

class ResetPassController {
  late BuildContext _context;
  ResetPassController(BuildContext context) {
    this._context = context;
  }

  sendOtp(GlobalKey<FormState> key, TextEditingController email) async {
    if (key.currentState!.validate()) {
      String data = DataProcess.getEncryptedData(email.text);
      Response response = await ApiService.postMethod(
          "https://studenthub.smartcampus.com.my/api/Home/StudentMobileApi/ResetPasswordRequest?input=$data",
          allowFullUrl: false,
          allowToken: false);
      DataModel dataModel = DataModel.fromJson(response.data);
      if (dataModel.hasError!) {
        showMessage(dataModel.errors!.first);
      } else {
        PassResetModel passResetModel = PassResetModel.fromJson(
            jsonDecode(DataProcess.getDecryptedData(dataModel.data!)));
        passResetModel.email = email.text;
        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (_) => Pin(
              passResetModel: passResetModel,
            ),
          ),
        );
      }
    }
  }
}
