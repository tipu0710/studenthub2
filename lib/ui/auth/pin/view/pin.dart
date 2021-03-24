import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:studenthub2/ui/auth/pin/controller/pin_controller.dart';
import '../../../../ui_helper/ui_helper.dart';

class Pin extends StatefulWidget {
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  String otp = "";

  PinController pinController;

  @override
  void dispose() {
    errorController.close();
    pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()..onTap = () async {};
    errorController = StreamController<ErrorAnimationType>();
    pinController = PinController(context, errorController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: -20,
            right: -10,
            child: Image.asset(
              "assets/images/reg_img.png",
              height: 246,
              width: 246,
            ),
          ),
          body(),
          UiHelper().back(context, onTap: () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 171, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Sign Up New Student',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: const Color(0xff252525),
                  fontWeight: FontWeight.w500,
                  height: 1.8,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'Input your PIN code from email registered',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  color: const Color(0xff727272),
                  height: 2.4,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ),
            pinField(),
            UiHelper().button(
                context: context,
                title: "REGISTER",
                onPressed: () {
                  pinController.checkPin(otp);
                },
                topMargin: 10),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Resend The Code',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  color: const Color(0xffff3939),
                  height: 1.5,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pinField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: PinCodeTextField(
        backgroundColor: Colors.transparent,
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        cursorHeight: 25,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.white,
            inactiveColor: Colors.white,
            activeColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedColor: Colors.white,
            selectedFillColor: Colors.white),
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: textEditingController,
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          otp = value;
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
      ),
    );
  }
}
