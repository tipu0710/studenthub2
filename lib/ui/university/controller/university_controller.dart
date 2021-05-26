import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:studenthub2/ui/university/model/university_mode.dart';

class UniversityController {
  List<UniversityModel> _uniList = [];
  StreamController<List<UniversityModel>>? _streamController;

  UniversityController(
      StreamController<List<UniversityModel>> streamController) {
    this._streamController = streamController;
    _getUniList();
  }

  updateController(String value) async {
    Iterable list = _uniList.where(
        (element) => element.name!.toLowerCase().contains(value.toLowerCase()));
    List<UniversityModel> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    _streamController!.add(finalList);
  }

  void _getUniList() async {
    Response response = await ApiService.getMethod(
        "/InstituteMobileApi/GetInstituteList",
        allowToken: false);

    Iterable iterable =
        jsonDecode(DataProcess.getDecryptedData(response.data['Data']));
    iterable.forEach((element) {
      _uniList.add(UniversityModel.fromJson(element));
    });
  }

  addToSP(BuildContext context, UniversityModel universityModel, bool fromReg) {
    SPData.spData.setUniversity(universityModel);
    if (!fromReg) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => Login(),
          ),
          (route) => false);
    } else {
      Navigator.pop(context);
    }
  }

  dispose() {
    _streamController?.close();
  }
}
