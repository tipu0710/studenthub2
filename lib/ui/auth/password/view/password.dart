import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/ui/auth/password/controller/password_controller.dart';
import 'package:studenthub2/ui/auth/reset_pass/model/reset_pass_model.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Password extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController rePassController = TextEditingController();
  final ValueNotifier<bool> passVisible = ValueNotifier(false);

  final PassResetModel passResetModel;

  Password({Key key, this.passResetModel}) : super(key: key);

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
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
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
              ValueListenableBuilder(
                  valueListenable: passVisible,
                  builder: (_, visible, __) => UiHelper().input(
                          rePassController, "Confirm Password",
                          obscureText: !visible,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                              icon: Icon(
                                  visible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                                  color: Color(0xffB4B4B4)),
                              onPressed: () {
                                passVisible.value = !visible;
                              }),
                          validator: (value) {
                        if (value == passController.text) {
                          return null;
                        } else {
                          return "Password doesn't match";
                        }
                      })),
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
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      PasswordController pass = PasswordController(context,
                          passResetModel: passResetModel);
                      if (passResetModel != null) {
                        await pass.resetPassword(passController.text);
                      } else {
                        await pass.setInitPassword(passController.text);
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
