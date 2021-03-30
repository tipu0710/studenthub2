import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 258,
              margin: EdgeInsets.only(top: 107),
              child: Image.asset(
                "assets/images/pp_back.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 200),
                child: Column(
                  children: [
                    Container(
                      height: 158,
                      width: 158,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xff1e5aa7),
                        image: DecorationImage(
                          image: const AssetImage('assets/images/test/pp.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      child: Text(
                        profileModel.fullName,
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
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Text(
                        profileModel.id,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          color: const Color(0xffc6c6c6),
                          fontWeight: FontWeight.w500,
                          height: 2.4,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        profileModel.institutionDetails.programmeName,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: const Color(0xff1e5aa7),
                          fontWeight: FontWeight.w500,
                          height: 2,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 114),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: const Color(0xff727272),
                            height: 1.2,
                          ),
                          children: [
                            TextSpan(
                              text: 'University of',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ' \n',
                              style: TextStyle(
                                color: const Color(0xff252525),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text:
                                  profileModel.institutionDetails.instituteName,
                              style: TextStyle(
                                fontSize: 25,
                                color: const Color(0xff252525),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          UiHelper().back(context, title: 'Profile'),
        ],
      ),
    );
  }
}
