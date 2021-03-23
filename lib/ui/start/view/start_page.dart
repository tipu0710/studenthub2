import 'package:flutter/material.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:studenthub2/ui/auth/register/view/register.dart';
import '../../../ui_helper/ui_helper.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 311.45,
              child: Image.asset(
                "assets/images/started_curve.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 393,
              width: 457,
              child: Image.asset(
                "assets/images/started_image.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          loginRow(),
          bottom(context),
        ],
      ),
    );
  }

  Widget loginRow() {
    return Align(
      alignment: Alignment.topCenter,
      child: Builder(
        builder: (context) => InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
          },
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'StudentHub',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: const Color(0xff252525),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: const Color(0xff252525),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottom(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Let\'s Get Started',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 32,
              color: const Color(0xff252525),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            'Everything works Better together',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: const Color(0xff727272),
            ),
            textAlign: TextAlign.left,
          ),
          UiHelper().button(
              context: context,
              title: 'SIGN UP',
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Register()));
              }),
        ],
      ),
    );
  }
}
