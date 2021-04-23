import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui/profile/controller/profile_controller.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 160,
                      width: 160,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 158,
                              width: 158,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff1e5aa7),
                                image: DecorationImage(
                                  image: _image == null
                                      ? profileModel?.institutionDetails?.image ==
                                              null
                                          ? AssetImage('assets/images/user.png')
                                          : CachedNetworkImageProvider(
                                              ApiService.baseUrl +
                                                  profileModel
                                                      .institutionDetails.image)
                                      : FileImage(_image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
                                ProfileController profileController =
                                    ProfileController(context);
                                _image = await profileController.getImage();
                                setState(() {
                                  print("back");
                                });
                              },
                              child: Container(
                                height: 31,
                                width: 31,
                                margin:
                                    EdgeInsets.only(top: 100 + 10.0, left: 120),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xffffffff),
                                  border: Border.all(
                                      width: 2.0,
                                      color: const Color(0xff28ABF7)),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add_a_photo_sharp,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 35),
                      child: Text(
                        profileModel?.fullName??"",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 22,
                          color: const Color(0xff252525),
                          fontWeight: FontWeight.w500,
                          height: 1.6363636363636365,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      child: Text(
                        profileModel?.institutionDetails?.matricId??"",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          color: const Color(0xffc6c6c6),
                          fontWeight: FontWeight.w500,
                          height: 2.4,
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50, bottom: 20),
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
