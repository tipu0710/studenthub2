import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';

import '../../../ui_helper/ui_helper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();

  final FocusNode passFocus = FocusNode();

  final ValueNotifier<bool> passVisible = ValueNotifier(false);

  bool rememberValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 311.45,
              child: Image.asset(
                "assets/images/login_curve.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/sb_text.png",
                      height: 41.02,
                      width: 186.82,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ',
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
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  email(),
                  password(),
                  remember(),
                  SizedBox(
                    height: 40,
                  ),
                  UiHelper().button(
                      context: context,
                      title: "LOGIN",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => Parent()),
                            (route) => false);
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  tfp()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tfp() {
    return Container(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/tfplogo.png",
            fit: BoxFit.fitHeight,
          ),
          Text(
            '  TFP Solutions',
            style: TextStyle(
              fontFamily: 'Microsoft YaHei UI',
              fontSize: 15,
              color: const Color(0xff494949),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget remember() {
    return Container(
      height: 20,
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remember me next time ',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              color: const Color(0xff252525),
            ),
            textAlign: TextAlign.left,
          ),
          FittedBox(
            child: CupertinoSwitch(
              value: rememberValue,
              activeColor: Color(0xff1E5AA7),
              onChanged: (value) {
                setState(() {
                  rememberValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget email() {
    return Builder(
        builder: (context) => TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            focusNode: emailFocus,
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              color: const Color(0xff1e5aa7),
              fontWeight: FontWeight.w500,
            ),
            onFieldSubmitted: (v) {
              FocusScope.of(context).requestFocus(passFocus);
            },
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
            }));
  }

  Widget password() {
    return ValueListenableBuilder<bool>(
      valueListenable: passVisible,
      builder: (_, visible, __) => TextFormField(
          keyboardType: TextInputType.visiblePassword,
          controller: passwordController,
          focusNode: passFocus,
          obscureText: !visible,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: const Color(0xff1e5aa7),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xff252525),
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: Color(0xffB4B4B4),
              ),
              suffixIcon: IconButton(
                  icon: Icon(
                      visible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                      color: Color(0xffB4B4B4)),
                  onPressed: () {
                    passVisible.value = !visible;
                  }),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD9D9D9))),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              errorStyle: TextStyle(color: Colors.red, fontSize: 10)),
          validator: (value) {
            if (value.isEmpty) return "Password is required";
            return null;
          }),
    );
  }
}
