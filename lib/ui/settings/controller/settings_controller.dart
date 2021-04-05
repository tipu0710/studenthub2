import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
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
}
