import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';
import 'package:url_launcher/url_launcher.dart';

enum AppType { web, fb, instagram, email }

class SettingsController {
  BuildContext _context;
  SettingsController(BuildContext context) {
    this._context = context;
  }
  logout() {
    SPData.spData.removeLoginInfo();
    SPData.spData.removeRegInfo();
    setProfile = null;
    setLoginInfo = null;
    Navigator.pushAndRemoveUntil(
        _context, MaterialPageRoute(builder: (_) => Login()), (route) => false);
  }

  launchUrl(String url, AppType appType) async {
    switch (appType) {
      case AppType.email:
        await launch('mailto:$url');
        break;
      case AppType.web:
      case AppType.instagram:
        await launch(url,
            universalLinksOnly: true,
            forceSafariVC: false,
            forceWebView: false);
        break;
      case AppType.fb:
        bool b = await launch("fb://facewebmodal/f?href=$url",
            forceSafariVC: false,
            universalLinksOnly: true,
            forceWebView: false);
        print(b);
        if (!b) {
          await launch(url);
        }
        break;
    }
  }

  contactUs() async {
    var margin = 20.0;
    await showDialog(
      context: _context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Material(
          child: Container(
            width: 320.0,
            height: 270,
            padding: EdgeInsets.only(
                left: margin * 2,
                right: margin * 2,
                top: margin,
                bottom: margin),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  institute.contactDetails,
                  style: TextStyle(height: 1.5),
                ),
                UiHelper().button(
                    context: _context,
                    title: "OK",
                    height: 30,
                    width: 55,
                    topMargin: 20,
                    fontSize: 12,
                    onPressed: () {
                      Navigator.pop(_context);
                    })
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
