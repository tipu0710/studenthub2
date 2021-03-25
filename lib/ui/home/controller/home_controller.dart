import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/home/model/home_model.dart';
import 'package:studenthub2/ui/profile/controller/profile_controller.dart';

class HomeController {
  HomeModel homeModel;
  BuildContext _context;
  HomeController(BuildContext context) {
    this._context = context;
  }

  Future<bool> getDashboard() async {
    await ProfileController.getProfile();
    Response response =
        await ApiService.getMethod("/DashboardMobileApi/GetDashBoardDataExtra");
    try {} catch (e) {
      throw e;
    }
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
    } else {
      homeModel = HomeModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(dataModel.dataExtra)));
    }
    return !dataModel.hasError;
  }

  List<List<Color>> _colorList = [
    [Color(0xffEEF6FF), Color(0xff5F9DEE)],
    [Color(0xffF2FCFF), Color(0xff78cce2)],
    [Color(0xffe7e0ff), Color(0xff967fe2)],
    [Color(0xfffee0ff), Color(0xffd07fe2)],
    [Color(0xffffe0e0), Color(0xffe27f7f)],
    [Color(0xfffff6e0), Color(0xffe2c67f)],
    [Color(0xfff1ffe0), Color(0xffa5e27f)],
    [Color(0xffe0fff2), Color(0xff7fe2c3)],
    [Color(0xffe0f8ff), Color(0xff7fc3e2)],
  ];

  List<Color> getColor(int position) {
    return _colorList[position % _colorList.length];
  }
}
