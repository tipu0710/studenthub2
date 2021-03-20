import 'package:flutter/material.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class QrScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/test/qr.png",
              height: 291,
              width: 291,
            ),
          ),
          UiHelper().back(context, title: "Qr Code")
        ],
      ),
    );
  }
}
