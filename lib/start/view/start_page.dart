import 'package:flutter/material.dart';
import 'package:studenthub2/login/view/login.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child:Container(
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
          bottom(),
        ],
      ),
    );
  }

  Widget loginRow() {
    return Align(
      alignment: Alignment.topCenter,
      child: Builder(
        builder: (context)=>InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>Login()));
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

  Widget bottom() {
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
          Container(
            height: 55,
              width: 335,
            margin: EdgeInsets.only(top: 40,bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xff1e5aa7),
            ),
            child: Center(
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  height: 0.8,
                ),
                textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}