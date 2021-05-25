import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/model/login_model.dart';
import 'package:studenthub2/ui/auth/reset_pass/view/reset_pass.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:studenthub2/ui/profile/controller/profile_controller.dart';
import 'package:studenthub2/ui/university/model/university_mode.dart';

class LoginController {
  late BuildContext _context;
  LoginController(BuildContext context) {
    this._context = context;
  }

  login(String email, String password) async {
    Map<String, dynamic> map = {
      "username": email,
      "password": password,
      "key": "TFPCOMMYSTUDENTHUBPORTAL"
    };

    Response response = await ApiService.postMethod(
        "https://studenthub.smartcampus.com.my/api/Home/StudentMobileApi/Login?input=${DataProcess.getEncryptedData(jsonEncode(map))}",
        allowFullUrl: false,
        allowToken: false);

    DataModel dataModel = DataModel.fromJson(response.data);

    if (dataModel.hasError!) {
      showMessage(dataModel.errors!.first);
    } else {
      LoginModel loginModel = LoginModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(dataModel.data!)));

      SPData.spData.saveLoginInfo(loginModel);

      setLoginInfo = loginModel;

      await ProfileController.getProfile();

      UniversityModel universityModel = SPData.spData.getUniversity()!;

      if (profileModel!.institutionDetails!.instituteName ==
          universityModel.name) {
        Navigator.pushAndRemoveUntil(_context,
            MaterialPageRoute(builder: (_) => Parent()), (route) => false);
      } else {
        showMessage(
          "Please select correct university!\nUniversity doesn't match!",
          toastPosition: ToastPosition.center,
        );
        setLoginInfo = null;
        await SPData.spData.removeLoginInfo();
      }
    }
  }

  void gotoResetPass() {
    Navigator.push(
        _context, MaterialPageRoute(builder: (_) => ResetPassword()));
  }
}
