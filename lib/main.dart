import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/university/view/university.dart';

import 'ui/auth/login/view/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await SPData.spData.initSP();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: primaryColor,
          scaffoldBackgroundColor: Color(0xfffcfcfc)),
      debugShowCheckedModeBanner: false,
      home: SPData.spData.sharedPreferences.containsKey("UNI")
          ? Login()
          : University(),
    );
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