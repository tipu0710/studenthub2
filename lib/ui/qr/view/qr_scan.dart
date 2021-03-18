import 'package:flutter/material.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class QrScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/test/qr.png",
              height: 291,
              width: 291,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: button(),
          ),
          UiHelper().back(context, title: "Qr Code")
        ],
      ),
    );
  }

  Widget button() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      width: 335.0,
      height: 45.0,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0f000123),
                  offset: Offset(0, 8),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 50),
                child: Text(
                  'MY CODE',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    color: const Color(0xff252525),
                    fontWeight: FontWeight.w500,
                    height: 0.9230769230769231,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          Container(
            width: 165,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: const Color(0xff1e5aa7),
            ),
            child: Center(
              child: Text(
                'SCAN',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w500,
                  height: 0.9230769230769231,
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
