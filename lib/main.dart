import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/model/login_model.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:studenthub2/ui/university/view/university.dart';

import 'ui/auth/login/view/login.dart';
import 'ui/calendar/controller/notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await SPData.spData.initSP();
  await NotificationController.n.initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotificationController.context = context;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: primaryColor,
            scaffoldBackgroundColor: Color(0xfffcfcfc)),
        debugShowCheckedModeBanner: false,
        home: getHome(),
      ),
    );
  }

  Widget getHome() {
    LoginModel loginModel = SPData.spData.getLoginInfo();
    if(loginModel!=null){
      setLoginInfo = loginModel;
    }
    return loginModel == null
        ? SPData.spData.getUniversity() != null
            ? Login()
            : University()
        : Parent();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
