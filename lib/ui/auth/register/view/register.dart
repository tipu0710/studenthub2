import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/auth/model/country_model.dart';
import 'package:studenthub2/ui/auth/register/controller/reg_controller.dart';
import 'package:studenthub2/ui/pin/view/pin.dart';
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

  RegisterController registerController;

  @override
  void initState() {
    registerController = RegisterController(_countryStream);
    super.initState();
  }

  @override
  void dispose() {
    _countryStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                    gender(),
                    UiHelper().input(phoneNumber, "Phone Number",
                        textInputType: TextInputType.phone),
                    UiHelper().input(email, "Email",
                        textInputType: TextInputType.emailAddress),
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
                      _countryStream.add([]);
                    }),
                    UiHelper().input(referralCode, "Referral Code",
                        textInputType: TextInputType.emailAddress),
                    UiHelper().input(program, "Program",
                        textInputType: TextInputType.emailAddress),
                    UiHelper().input(intake, "Intake",
                        textInputType: TextInputType.emailAddress),
                    UiHelper().button(
                        context: context,
                        title: "REQUEST PIN CODE",
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) => Pin()));
                        }),
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

  Widget gender() {
    String type = "Male";
    ValueNotifier<String> valueNotifier = ValueNotifier(type);
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (_, value, __) {
          return Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Expanded(child: Container()),
                Container(
                  width: 100,
                  child: RadioListTile<String>(
                    title: Text(
                      'Male',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: const Color(0xffacacac),
                        height: 1.5625,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: primaryColor,
                    value: "Male",
                    groupValue: type,
                    onChanged: (String value) {
                      type = value;
                      valueNotifier.value = value;
                    },
                  ),
                ),
                Container(
                  width: 115,
                  child: RadioListTile<String>(
                    title: Text(
                      'Female',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: const Color(0xffacacac),
                        height: 1.5625,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: primaryColor,
                    value: "Rocket",
                    groupValue: type,
                    onChanged: (String value) {
                      type = value;
                      valueNotifier.value = value;
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
