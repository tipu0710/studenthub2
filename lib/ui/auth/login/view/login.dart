import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studenthub2/ui/auth/login/controller/login_controller.dart';
import 'package:studenthub2/ui/auth/register/view/register.dart';
import 'package:studenthub2/ui/university/view/university.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import '../../../../global.dart';

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

  final _formKey = GlobalKey<FormState>();

  late LoginController loginController;

  @override
  void initState() {
    loginController = LoginController(context);
    super.initState();
  }

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
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      child: SvgPicture.asset(
                        "assets/svg/logo_with_text.svg",
                        height: 185.9/3,
                        width: 424.25/3,
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
                    SizedBox(height: 5,),
                    SizedBox(
                      height: 15,
                      child: forgotPass(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    UiHelper().button(
                        context: context,
                        title: "LOGIN",
                        bottomMargin: 5,
                        anim: true,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await loginController.login(
                                emailController.text, passwordController.text);
                          }
                        }),
                    SizedBox(
                      height: 0,
                    ),
                    signUp(),
                    SizedBox(
                      height: 40,
                    ),
                    tfp(),
                    SizedBox(
                      height: 25,
                    ),
                    changeUni(),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget signUp() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Register()));
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(
              text: "New User? ",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 12,
                color: const Color(0xff252525),
                fontWeight: FontWeight.w500,
                height: 1.8,
              ),
              children: [
                TextSpan(
                    text: "  Sign Up",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      height: 1.8,
                    ))
              ]),
        ),
      ),
    );
  }

  Widget changeUni() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => University()));
      },
      child: Center(
        child: Text(
          'Change University?',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 17,
            color: primaryColor,
            fontWeight: FontWeight.w500,
            height: 1.8,
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.left,
        ),
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
            '  TFP SOLUTIONS BERHAD',
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
                labelText: "Email",
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
            if (value!.isEmpty) return "Password is required";
            return null;
          }),
    );
  }

  Widget forgotPass() {
    return GestureDetector(
      onTap: loginController.gotoResetPass,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13,
            color: const Color(0xff252525),
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
