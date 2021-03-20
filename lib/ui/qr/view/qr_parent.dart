import 'package:flutter/material.dart';
import 'package:studenthub2/ui/qr/view/qr_code.dart';
import 'package:studenthub2/ui/qr/view/qr_scan.dart';

enum PositionOfButton { left, right }

class QrParent extends StatefulWidget {
  @override
  _QrParentState createState() => _QrParentState();
}

class _QrParentState extends State<QrParent>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  PositionOfButton positionOfButton = PositionOfButton.left;
  double opacity = 1;
  String buttonText = 'SCAN';

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: tabController,
            children: [QrScan(), QrCode()],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: button(),
          )
        ],
      ),
    );
  }

  Widget button() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      width: 334.0,
      height: 45.0,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xffd8d8d8)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x0f000123),
                  offset: Offset(0, 8),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'SCAN',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        color: const Color(0xff252525),
                        fontWeight: FontWeight.w500,
                        height: 0.9230769230769231,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
                Expanded(
                    child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'MY CODE',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        color: const Color(0xff252525),
                        fontWeight: FontWeight.w500,
                        height: 0.9230769230769231,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            left: positionOfButton == PositionOfButton.left ? 0 : 167,
            child: Container(
              width: 167,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.0),
                color: const Color(0xff1e5aa7),
              ),
              child: Center(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 250),
                  opacity: opacity,
                  child: Text(
                    buttonText,
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w500,
                      height: 0.9230769230769231,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () async {
                        if (tabController.index != 0) {
                          tabController.animateTo(0);
                          setState(() {
                            positionOfButton = PositionOfButton.left;
                            opacity = 0;
                          });
                          await Future.delayed(Duration(milliseconds: 250));
                          setState(() {
                            buttonText = "SCAN";
                            opacity = 1;
                          });
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                      ))),
              Expanded(
                  child: GestureDetector(
                      onTap: () async {
                        if (tabController.index != 1) {
                          tabController.animateTo(1);
                          setState(() {
                            positionOfButton = PositionOfButton.right;
                            opacity = 0;
                          });
                          await Future.delayed(Duration(milliseconds: 250));
                          setState(() {
                            buttonText = "MY CODE";
                            opacity = 1;
                          });
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                      ))),
            ],
          )
        ],
      ),
    );
  }
}
