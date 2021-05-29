import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/splashScreen/splashScreen.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return OKToast(
      child: MaterialApp(
        title: 'StudentHub',
        theme: ThemeData(
            primarySwatch: primaryColor,
            scaffoldBackgroundColor: Color(0xfffcfcfc)),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }

}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
