import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/home/model/home_model.dart';
import 'package:studenthub2/ui/profile/controller/profile_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController {
  HomeModel homeModel;

  Future<bool> getDashboard() async {
    if(homeModel!=null){
      return true;
    }
    print("ggggggggg");
    await ProfileController.getProfile();
    Response response =
        await ApiService.getMethod("/DashboardMobileApi/GetDashBoardDataExtra");
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
    } else {
      homeModel = HomeModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(dataModel.dataExtra)));
      setInstitute = homeModel.institute;
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

  Future<bool> channelJoinLeave(int id, bool status, int position) async {
    print(id);
    Response response;
    String encrypt = DataProcess.getEncryptedData(id.toString());
    if (status) {
      response = await ApiService.postMethod(
          "/StudentProfileMobileApi/ChannelUnSubscribe?input=$encrypt");
    } else {
      response = await ApiService.postMethod(
          "/StudentProfileMobileApi/ChannelSubscribe?input=$encrypt");
    }
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      print(dataModel.errors);
      showMessage(dataModel.errors.first);
      return null;
    } else {
      showMessage(status ? "Leaved!" : "Joined");
      return !status;
    }
  }

  launchUrl(String url) async {
    if (url == null || url.isEmpty) {
      print("Not available!");
    } else if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Not available!");
    }
  }
}
