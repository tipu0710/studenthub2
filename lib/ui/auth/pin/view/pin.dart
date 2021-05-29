import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/auth/pin/controller/pin_controller.dart';
import 'package:studenthub2/ui/auth/reset_pass/model/reset_pass_model.dart';
import '../../../../ui_helper/ui_helper.dart';

class Pin extends StatefulWidget {
  /// [passResetModel] will provided only from reset password

  final PassResetModel? passResetModel;

  const Pin({Key? key, this.passResetModel}) : super(key: key);
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();

  String otp = "";

  ValueNotifier<int> valueNotifier = new ValueNotifier(60 * 2);

  late PinController pinController;

  Timer? _timer;

  @override
  void dispose() {
    errorController!.close();
    pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    pinController = PinController(context, errorController,
        passResetModel: widget.passResetModel);
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        if (valueNotifier.value == 0) {
          await pinController.resendCode();
          valueNotifier.value = 60 * 2;
          playTimer();
          setState(() {
            showMessage("Code send!\nCheck email!");
          });
        }
      };
    playTimer();
    super.initState();
  }

  void playTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (valueNotifier.value > 0) {
        valueNotifier.value = valueNotifier.value - 1;
      } else {
        _timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiHelper.appBar(context, onTap: () {
        Navigator.pop(context);
      }),
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
        ],
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                widget.passResetModel != null
                    ? "Reset Password"
                    : 'Sign Up New Student',
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
                title: widget.passResetModel != null ? "SUBMIT" : "REGISTER",
                anim: true,
                onPressed: () async {
                  await pinController.checkPin(otp);
                },
                topMargin: 10),
            widget.passResetModel != null
                ? Container()
                : ValueListenableBuilder<int>(
                    valueListenable: valueNotifier,
                    builder: (_, value, __) {
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Didn't receive the code? ",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: value == 0
                                      ? " RESEND"
                                      : " Wait $value sec",
                                  recognizer: onTapRecognizer,
                                  style: TextStyle(
                                      color: value == 0
                                          ? Color(0xFFFF4646)
                                          : primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ]),
                      );
                    },
                  ),
            // widget.passResetModel != null
            //     ? Container()
            //     : GestureDetector(
            //         onTap: () {
            //           pinController.resendCode();
            //         },
            //         child: Container(
            //           margin: EdgeInsets.only(top: 20),
            //           child: Text(
            //             'Resend The Code',
            //             style: TextStyle(
            //               fontFamily: 'Roboto',
            //               fontSize: 12,
            //               color: const Color(0xffff3939),
            //               height: 1.5,
            //             ),
            //             textHeightBehavior:
            //                 TextHeightBehavior(applyHeightToFirstAscent: false),
            //             textAlign: TextAlign.center,
            //           ),
            //         ),
            //       )
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
        length: widget.passResetModel == null
            ? pinController.studentRegModel!.otp!.length
            : widget.passResetModel!.code!.length,
        obscureText: false,
        animationType: AnimationType.fade,
        cursorHeight: 25,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          borderWidth: 1.5,
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.grey.withOpacity(0.5),
          inactiveColor: Colors.grey.withOpacity(0.5),
          activeColor: Colors.grey.withOpacity(0.5),
          inactiveFillColor: Colors.grey.withOpacity(0.5),
          selectedColor: Colors.grey.withOpacity(0.5),
          selectedFillColor: Colors.grey.withOpacity(0.5),
        ),
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        cursorColor: primaryColor,
        keyboardType: TextInputType.number,
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
