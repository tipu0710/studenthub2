import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  profileImage(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
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
                  SizedBox(height: 3),
                  Text(
                    profileModel.institutionDetails.programmeName,
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
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
            ),
          ),
          UiHelper().back(context, title: "Qr Code")
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
          image: profileModel.institutionDetails.image == null
              ? AssetImage('assets/images/user.png')
              : CachedNetworkImageProvider(
                  ApiService.baseUrl + profileModel.institutionDetails.image),
          fit: BoxFit.cover,
        ),
        border: Border.all(width: 5.0, color: const Color(0xffffffff)),
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
        border: Border.all(width: 1.0, color: const Color(0xffd6d6d6)),
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
        border: Border.all(width: 1.0, color: const Color(0xff1e5aa7)),
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
            SizedBox(
              width: 5,
            ),
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
          Icon(
            Icons.save_alt,
            color: Color(0xffb4b4b4),
            size: 11,
          ),
          Text(
            'Save to gallery',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              color: const Color(0xffb4b4b4),
            ),
            textHeightBehavior:
                TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
