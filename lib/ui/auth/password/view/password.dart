import 'package:flutter/material.dart';
import 'package:studenthub2/ui/auth/password/controller/password_controller.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Password extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController rePassController = TextEditingController();
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
          body(context),
          UiHelper().back(context, onTap: () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Set your password',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: const Color(0xff252525),
                    fontWeight: FontWeight.w500,
                    height: 1.8,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              UiHelper().input(passController, "Password",
                  textInputType: TextInputType.visiblePassword,
                  validator: (value) {
                RegExp regExp =
                    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])[\w! @#$%^&*()+-/.]{8,}$")
                      ..isCaseSensitive;
                bool matches = regExp.hasMatch(value);
                if (matches) {
                  return null;
                } else {
                  return "Invalid Password";
                }
              }),
              UiHelper().input(rePassController, "Confirm Password",
                  textInputAction: TextInputAction.done, validator: (value) {
                if (value == passController.text) {
                  return null;
                } else {
                  return "Password doesn't match";
                }
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "*Your password needs to be length of 8 and\ncontain upper case and lower case",
                    style: TextStyle(color: const Color(0xff252525)),
                  ),
                ),
              ),
              UiHelper().button(
                  context: context,
                  title: "CONFIRM",
                  anim: true,
                  color: Colors.green,
                  onPressed: () async{
                    if (_formKey.currentState.validate()) {
                      PasswordController pass = PasswordController(context);
                      await pass.setInitPassword(passController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
