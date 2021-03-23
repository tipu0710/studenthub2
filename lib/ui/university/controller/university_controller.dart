import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:studenthub2/ui/university/model/university_mode.dart';

class UniversityController {
  updateController(StreamController<List<UniversityModel>> streamController,
      String value) async {
    List<UniversityModel> list = await getUniList(value);
    streamController.add(list);
  }

  Future<List<UniversityModel>> getUniList(String value) async {
    List<UniversityModel> list = <UniversityModel>[];
    Response response = await ApiService.getMethod(
        "http://universities.hipolabs.com/search?name=$value",
        addBaseUrl: false);

    Iterable iterable = response.data;
    iterable.forEach((element) {
      list.add(UniversityModel.fromJson(element));
    });

    return list;
  }

  addToSP(BuildContext context, UniversityModel universityModel){
    SPData.spData.setUniversity(universityModel);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Login(),
      ),
    );
  }
}
