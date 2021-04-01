import 'dart:async';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/model/country_model.dart';
import 'package:studenthub2/ui/auth/register/controller/reg_controller.dart';
import 'package:studenthub2/ui/auth/register/model/intake.dart';
import 'package:studenthub2/ui/auth/register/model/register_model.dart';
import 'package:studenthub2/ui/university/model/university_mode.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import '../../../../ui_helper/ui_helper.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController passport = TextEditingController();

  final TextEditingController fullName = TextEditingController();

  final TextEditingController studentId = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController country = TextEditingController();

  final TextEditingController referralCode = TextEditingController();

  final TextEditingController program = TextEditingController();

  final TextEditingController intake = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final StreamController<List<CountryModel>> _countryStream =
      StreamController<List<CountryModel>>.broadcast();

  final StreamController<List<ProgrammeList>> _programStream =
      StreamController<List<ProgrammeList>>.broadcast();

  final StreamController<List<IntakeList>> _intakeStream =
      StreamController<List<IntakeList>>.broadcast();

  CountryModel countryModel;
  IntakeList intakeList;
  ProgrammeList programmeList;

  RegisterController registerController;

  int gender = 0;

  @override
  void initState() {
    registerController = RegisterController(
        context, _countryStream, _programStream, _intakeStream);
    super.initState();
  }

  @override
  void dispose() {
    _countryStream.close();
    _programStream.close();
    _intakeStream.close();
    registerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: -30,
            child: Image.asset(
              "assets/images/reg_img.png",
              height: 246,
              width: 246,
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    UiHelper().input(passport, "NRIC/Passport"),
                    UiHelper().input(fullName, "Full Name"),
                    UiHelper().input(studentId, "Student ID"),
                    genderField(),
                    UiHelper().input(phoneNumber, "Phone Number",
                        textInputType: TextInputType.phone),
                    UiHelper().input(email, "Email",
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                      if (value.isEmpty) return "Email is required";
                      RegExp regExp = new RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                        caseSensitive: false,
                        multiLine: false,
                      );
                      if (!regExp.hasMatch(value)) {
                        return 'Invalid Email';
                      }
                      return null;
                    }),
                    UiHelper().input(country, "Country",
                        textInputType: TextInputType.emailAddress,
                        onChange: (value) {
                      registerController.updateCountryStream(value);
                    }),
                    UiHelper().searchItem<CountryModel>(_countryStream,
                        titleGetFunction: (country) {
                      return country.name;
                    }, onTap: (c) {
                      country.text = c.name;
                      countryModel = c;
                      _countryStream.add([]);
                    }),
                    Focus(
                      onFocusChange: (b) {
                        if (!b && referralCode.text.isNotEmpty) {
                          registerController.getReferInfo(referralCode.text);
                        }
                      },
                      child: UiHelper()
                          .input(referralCode, "Referral Code", capsOn: true),
                    ),
                    UiHelper().input(program, "Program", onChange: (value) {
                      registerController.updateProgramStream(value);
                    }),
                    UiHelper().searchItem<ProgrammeList>(_programStream,
                        titleGetFunction: (program) {
                      return program.name;
                    }, onTap: (c) {
                      program.text = c.name;
                      programmeList = c;
                      _programStream.add([]);
                    }),
                    UiHelper().input(intake, "Intake", onChange: (value) {
                      registerController.updateIntakeStream(value);
                    }),
                    UiHelper().searchItem<IntakeList>(_intakeStream,
                        titleGetFunction: (country) {
                      return country.name;
                    }, onTap: (c) {
                      intake.text = c.name;
                      intakeList = c;
                      _intakeStream.add([]);
                    }),
                    UiHelper().button(
                      context: context,
                      title: "REQUEST PIN CODE",
                      onPressed: validate,
                      anim: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          UiHelper().back(context, onTap: () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  validate() async {
    if (_formKey.currentState.validate()) {
      UniversityModel uni = SPData.spData.getUniversity();
      RegisterModel registerModel = RegisterModel(
          contactNumber: phoneNumber.text,
          countryId: countryModel.id,
          emailAddress: email.text,
          fullName: fullName.text,
          identityNumber: passport.text,
          instituteId: uni.id,
          intakeId: intakeList.id,
          programmeId: programmeList.id,
          sex: gender.toString(),
          studentId: studentId.text);
      await registerController.register(registerModel);
    }
  }

  Widget genderField() {
    ValueNotifier<int> valueNotifier = ValueNotifier(gender);
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (_, value, __) {
          return Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sex',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: const Color(0xff252525),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: RadioListTile<int>(
                        title: Text(
                          'Male',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: const Color(0xffacacac),
                            height: 1.5625,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                        contentPadding: EdgeInsets.zero,
                        activeColor: primaryColor,
                        value: 0,
                        groupValue: gender,
                        onChanged: (int value) {
                          gender = value;
                          valueNotifier.value = value;
                        },
                      ),
                    ),
                    Container(
                      width: 115,
                      child: RadioListTile<int>(
                        title: Text(
                          'Female',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: const Color(0xffacacac),
                            height: 1.5625,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                        contentPadding: EdgeInsets.zero,
                        activeColor: primaryColor,
                        value: 1,
                        groupValue: gender,
                        onChanged: (int value) {
                          gender = value;
                          valueNotifier.value = value;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
