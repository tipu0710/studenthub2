import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class QrCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 130,),
                  profileImage(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Adem Smith',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      color: const Color(0xff252525),
                      fontWeight: FontWeight.w500,
                      height: 1.6363636363636365,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Webspert.com',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: const Color(0xffc6c6c6),
                      height: 2.4,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                  qrCode(),
                  shareCode(),
                  saveCode(),
                  SizedBox(height: 120,)
                ],
              ),
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

  Widget profileImage() {
    return Container(
      width: 96.0,
      height: 96.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: const AssetImage('assets/images/test/pp.png'),
          fit: BoxFit.cover,
        ),
        border:
        Border.all(width: 5.0, color: const Color(0xffffffff)),
      ),
    );
  }

  Widget qrCode() {
    return Container(
      width: 161.0,
      height: 161.0,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        color: const Color(0xffffffff),
        border:
        Border.all(width: 1.0, color: const Color(0xffd6d6d6)),
      ),
      child: Center(
        child: Image.asset(
          "assets/images/test/qr-code.png",
          height: 93.88,
          width: 93.88,
        ),
      ),
    );
  }

  Widget shareCode() {
    return Container(
      width: 161.0,
      height: 33.0,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xfff9ffff),
        border:
        Border.all(width: 1.0, color: const Color(0xff1e5aa7)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.share,
              color: Color(0xff1E5AA7),
              size: 11,
            ),
            SizedBox(width: 5,),
            Text(
              'Share My Code',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                color: const Color(0xff1e5aa7),
                fontWeight: FontWeight.w500,
              ),
              textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget saveCode() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.save_alt, color: Color(0xffb4b4b4), size: 11,),
          Text(
            'Save to gallery',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              color: const Color(0xffb4b4b4),
            ),
            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
