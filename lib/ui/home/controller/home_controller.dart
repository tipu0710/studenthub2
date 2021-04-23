import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/calendar/view/event_create_dialog.dart';
import 'package:studenthub2/ui/home/model/announcement.dart';
import 'package:studenthub2/ui/home/model/event.dart';
import 'package:studenthub2/ui/home/model/home_model.dart';
import 'package:studenthub2/ui/profile/controller/profile_controller.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController {
  HomeModel homeModel;
  BuildContext _context;
  HomeController(BuildContext context) {
    this._context = context;
  }

  Future<bool> getDashboard() async {
    if (homeModel != null) {
      return true;
    }
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

  Future<bool> _channelJoinLeave(String id, bool status) async {
    print(id);
    Response response;
    String encrypt = DataProcess.getEncryptedData(id);
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


  Future<bool> channelJoinLeave(String title, String description, String id,
      Color cardColor, bool status) async {
    var margin = 20.0;
    return await showDialog<bool>(
          context: _context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(_context).size.height * .8),
                child: Container(
                  width: 320.0,
                  padding: EdgeInsets.only(
                      left: margin, right: margin, top: margin, bottom: margin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 40, left: 20, right: 20, bottom: 20),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: const Color(0xff252525),
                            fontWeight: FontWeight.w500,
                            height: 1.8,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(height: 1.5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UiHelper().button(
                              context: _context,
                              title: "BACK",
                              height: 30,
                              width: 70,
                              topMargin: 20,
                              fontSize: 11,
                              color: Colors.white,
                              textColor: Colors.black,
                              borderColor: Colors.grey,
                              onPressed: () {
                                Navigator.pop(_context);
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          UiHelper().button(
                              context: _context,
                              title: status ? "LEAVE" : "JOIN",
                              height: 30,
                              width: 70,
                              topMargin: 20,
                              fontSize: 11,
                              anim: true,
                              onPressed: () async {
                                bool b = await _channelJoinLeave(id, status);
                                Navigator.pop(_context, b);
                              }),
                        ],
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ) ??
        false;
  }
}
