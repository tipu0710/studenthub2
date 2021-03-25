import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:studenthub2/ui_helper/ui_helper.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 164,
                  ),
                  title('Quick Link'),
                  SizedBox(
                    height: 15,
                  ),
                  childCard("Uni Website"),
                  childCard("Uni Facebook"),
                  childCard("Uni Instagram"),
                  SizedBox(
                    height: 40,
                  ),
                  title('Help & Support'),
                  SizedBox(
                    height: 15,
                  ),
                  childCard("Contact Us"),
                  childCard("Uni Facebook"),
                  childCard("Uni Instagram"),
                  childCard("Logout", iconData: CupertinoIcons.power,
                      onTap: () {
                    SPData.spData.removeLoginInfo();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => Login()),
                        (route) => false);
                  }),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 30,
              color: Color(0xfffcfcfc),
            ),
          ),
          UiHelper().back(context, title: "Settings"),
        ],
      ),
    );
  }

  Widget childCard(String title, {IconData iconData, Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffeeeeee)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  color: const Color(0xff585858),
                ),
              ),
              Icon(
                iconData ?? Icons.arrow_forward_ios,
                color: Color(0xffACACAC),
                size: 14,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget title(String title) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 20,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: const Color(0xff373747),
          fontWeight: FontWeight.w500,
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.left,
      ),
    );
  }
}
