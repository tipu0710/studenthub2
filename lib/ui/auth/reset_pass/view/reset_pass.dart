import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/ui/auth/reset_pass/controller/reset_pass_controller.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  late ResetPassController resetPassController;

  @override
  void initState() {
    resetPassController = ResetPassController(context);
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
                'Reset password',
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
                'Enter your registered Email/Student ID',
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
            SizedBox(height: 30,),
            Form(key: _formKey, child: email()),
            SizedBox(height: 30,),
            UiHelper().button(
                context: context,
                title: "SEND OTP",
                anim: true,
                onPressed: () async {
                  await resetPassController.sendOtp(_formKey, emailController);
                },
                topMargin: 10),
          ],
        ),
      ),
    );
  }

  Widget email() {
    return Builder(
        builder: (context) => TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: const Color(0xff1e5aa7),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
                labelText: "Email/Student ID",
                labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: const Color(0xff252525),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  CupertinoIcons.person,
                  color: Color(0xffB4B4B4),
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffD9D9D9))),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: TextStyle(color: Colors.red, fontSize: 10)),
            validator: (value) {
              if (value!.isEmpty) return "Email is required";
              RegExp regExp = new RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                caseSensitive: false,
                multiLine: false,
              );
              if (!regExp.hasMatch(value)) {
                return 'Invalid Email';
              }
              return null;
            }));
  }
}
