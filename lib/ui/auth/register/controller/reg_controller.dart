import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
import 'package:studenthub2/ui/university/view/university.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterController {
  late StreamController<List<CountryModel>> streamCountry;

  late StreamController<List<ProgrammeList>> programStream;

  late StreamController<List<IntakeList>> intakeStream;

  List<CountryModel> _countryList = <CountryModel>[];

  List<IntakeList>? _intakeList = <IntakeList>[];

  List<ProgrammeList>? _programList = <ProgrammeList>[];

  Declaration? declaration;

  late BuildContext _context;

  RegisterController(BuildContext context) {
    this._context = context;
    this.streamCountry = StreamController<List<CountryModel>>.broadcast();
    this.programStream = StreamController<List<ProgrammeList>>.broadcast();
    this.intakeStream = StreamController<List<IntakeList>>.broadcast();
    _getCountries();
  }

  updateCountryStream(String data) {
    if (data.length < 1) return;
    Iterable list = _countryList.where(
        (element) => element.name!.toLowerCase().contains(data.toLowerCase()));
    List<CountryModel> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    streamCountry.add(finalList);
  }

  updateProgramStream(String data) {
    if (data.length < 1) return;
    Iterable list = _programList!.where(
        (element) => element.name!.toLowerCase().contains(data.toLowerCase()));
    List<ProgrammeList> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    programStream.add(finalList);
  }

  updateIntakeStream(String data) {
    if (data.length < 1) return;
    Iterable list = _intakeList!.where(
        (element) => element.name!.toLowerCase().contains(data.toLowerCase()));
    List<IntakeList> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    intakeStream.add(finalList);
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
    declaration = intakeModel.declaration;
    if (declaration!.instituteId.toString() !=
        SPData.spData.getUniversity()!.id) {
      UiHelper.showSnackMessage(
          context: _context,
          message: "Institute doesn't match!",
          snackBarActionTitle: "Change",
          onePressed: () {
            Navigator.push(
                _context, MaterialPageRoute(builder: (_) => University()));
          });
    }
    return true;
  }

  register(RegisterModel registerModel) async {
    StudentRegModel? studentRegModel = SPData.spData.getStudentRegInfo();
    if (studentRegModel != null) {
      print(studentRegModel.otp);
      RegisterModel reg = RegisterModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(studentRegModel.data!)));
      if (reg.emailAddress == registerModel.emailAddress &&
          !studentRegModel.verified!) {
        Navigator.push(_context, MaterialPageRoute(builder: (_) => Pin()));
        return;
      }
    }

    print(registerModel.fullName);
    registerModel.fullName = registerModel.fullName!.capitalize();
    print(registerModel.fullName);
    String s = jsonEncode(registerModel.toJson());
    Response response = await ApiService.postMethod(
        "https://studenthub.smartcampus.com.my/api/Home/StudentMobileApi/Register?input=${DataProcess.getEncryptedData(s)}",
        allowToken: false,
        allowFullUrl: false);
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError!) {
      print(dataModel.errors);
      showMessage(dataModel.errors!.first);
      return;
    }
    if (dataModel.dataExtra != null) {
      print(DataProcess.getDecryptedData(dataModel.dataExtra));
    }
    String otp =
        jsonDecode(DataProcess.getDecryptedData(dataModel.dataExtra))['OTP']
            .toString();
    print(otp);
    await SPData.spData.setStudentRegInfo(
        StudentRegModel(data: dataModel.data, verified: false, otp: otp));
    Navigator.push(_context, MaterialPageRoute(builder: (_) => Pin()));
  }

  Future<bool?> termsAndConditions() async {
    return await showDialog(
      context: _context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(_context).size.height - 60,
            minHeight: 200,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(top: 40, bottom: 20, right: 20, left: 20),
              child: Column(
                children: [
                  Text(
                    declaration?.name ?? "",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xff1e5aa7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HtmlWidget(
                    declaration?.declarationContent ?? "",
                    hyperlinkColor: primaryColor,
                    onTapUrl: (url) async {
                      await launch(url);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  UiHelper().button(
                    context: context,
                    width: 100,
                    height: 40,
                    title: "Accept",
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    intakeStream.close();
    programStream.close();
    streamCountry.close();
  }
}
