import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/qr/view/qr_code.dart';

void main() {
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
        scaffoldBackgroundColor: Color(0xfffcfcfc)
      ),
      debugShowCheckedModeBanner: false,
      home: QrCode(),
    );
  }

}

