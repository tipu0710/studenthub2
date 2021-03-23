import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/login/view/login.dart';
import 'package:studenthub2/ui/university/view/university.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
