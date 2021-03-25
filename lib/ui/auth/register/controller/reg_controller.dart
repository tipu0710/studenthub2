import 'dart:async';
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
import 'package:studenthub2/ui/auth/model/country_model.dart';
import 'package:studenthub2/ui/auth/pin/view/pin.dart';
import 'package:studenthub2/ui/auth/register/model/intake.dart';
import 'package:studenthub2/ui/auth/register/model/register_model.dart';

class RegisterController {
  StreamController<List<CountryModel>> _streamCountry;

  StreamController<List<ProgrammeList>> _programStream;

  StreamController<List<IntakeList>> _intakeStream;

  List<CountryModel> _countryList = <CountryModel>[];

  List<IntakeList> _intakeList = <IntakeList>[];

  List<ProgrammeList> _programList = <ProgrammeList>[];

  BuildContext _context;

  RegisterController(
      BuildContext context,
      StreamController<List<CountryModel>> streamCountry,
      StreamController<List<ProgrammeList>> programStream,
      StreamController<List<IntakeList>> intakeStream) {
    this._context = context;
    this._streamCountry = streamCountry;
    this._programStream = programStream;
    this._intakeStream = intakeStream;
    _getCountries();
  }

  updateCountryStream(String data) {
    if (data.length < 1) return;
    Iterable list = _countryList.where(
        (element) => element.name.toLowerCase().contains(data.toLowerCase()));
    List<CountryModel> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    _streamCountry.add(finalList);
  }

  updateProgramStream(String data) {
    if (data.length < 1) return;
    Iterable list = _programList.where(
        (element) => element.name.toLowerCase().contains(data.toLowerCase()));
    List<ProgrammeList> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    _programStream.add(finalList);
  }

  updateIntakeStream(String data) {
    if (data.length < 1) return;
    Iterable list = _intakeList.where(
        (element) => element.name.toLowerCase().contains(data.toLowerCase()));
    List<IntakeList> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    _intakeStream.add(finalList);
  }

  void _getCountries() async {
    Response response = await ApiService.getMethod(
        "/CountryMobileApi/GetPagedCountry?textkey=&pageSize=-1&pageNo=-1",
        allowToken: false);
    String s = DataProcess.getDecryptedData(response.data['Data']);
    Iterable iterable = jsonDecode(s);
    iterable.forEach((element) {
      _countryList.add(CountryModel.fromJson(element));
    });
  }

  Future<bool> getReferInfo(String refer) async {
    Response response = await ApiService.getMethod(
        "/InstituteMobileApi/GetInstituteByReferralCode?input=${DataProcess.getEncryptedData(refer)}",
        allowToken: false);
    String s = DataProcess.getDecryptedData(response.data['DataExtra']);
    IntakeModel intakeModel = IntakeModel.fromJson(jsonDecode(s));
    _intakeList = intakeModel.intakeList;
    _programList = intakeModel.programmeList;
    return true;
  }

  register(RegisterModel registerModel) async {
    StudentRegModel studentRegModel = SPData.spData.getStudentRegInfo();
    if (studentRegModel != null) {
      RegisterModel reg = RegisterModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(studentRegModel.data)));
      if (reg.emailAddress == registerModel.emailAddress &&
          !studentRegModel.verified) {
        Navigator.push(_context, MaterialPageRoute(builder: (_) => Pin()));
        return;
      }
    }
    String s = jsonEncode(registerModel.toJson());
    Response response = await ApiService.postMethod(
        "https://studenthub.smartcampus.com.my/api/Home/StudentMobileApi/Register?input=${DataProcess.getEncryptedData(s)}",
        allowToken: false,
        allowFullUrl: false);
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      print(dataModel.errors);
      showMessage(dataModel.errors.first);
      return;
    }
    if(dataModel.dataExtra!=null){
      print(DataProcess.getDecryptedData(dataModel.dataExtra));
    }
    await SPData.spData.setStudentRegInfo(
        StudentRegModel(data: dataModel.data, verified: false));
    print(DataProcess.getDecryptedData(dataModel.data));
    print(DataProcess.getDecryptedData(dataModel.dataExtra));
    Navigator.push(_context, MaterialPageRoute(builder: (_) => Pin()));
  }

  void dispose() {
    _intakeStream.close();
    _programStream.close();
    _streamCountry.close();
  }
}
