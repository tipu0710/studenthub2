import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:url_launcher/url_launcher.dart';

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

  launchUrl(String url) async {
    if (url == null || url.isEmpty) {
      showMessage("Not available!");
    } else if (await canLaunch(url)) {
      await launch(url);
    }else{
      showMessage("Not available!");
    }
  }
}
