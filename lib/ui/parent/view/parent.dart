import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenthub2/ui/home/view/home.dart';
import 'package:studenthub2/ui/notification/view/notification.dart';
import 'package:studenthub2/ui/profile/view/profile.dart';
import 'package:studenthub2/ui/qr/view/qr_parent.dart';
import 'package:studenthub2/ui/settings/view/settings.dart';
import 'package:studenthub2/ui_helper/custom_icons.dart';

class Parent extends StatefulWidget {
  static TabController tabController;
  @override
  _ParentState createState() => _ParentState();
}

class _ParentState extends State<Parent> with SingleTickerProviderStateMixin {
  int currentPage = 0;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Parent.tabController =
        TabController(length: 5, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          controller: Parent.tabController,
          children: [
            Home(),
            Profile(),
            QrParent(),
            Notifications(),
            Settings()
          ],
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: CustomIcons.home, title: "Home"),
            TabData(iconData: CustomIcons.user, title: "Profile"),
            TabData(iconData: CustomIcons.qr_code, title: "QR"),
            TabData(iconData: CustomIcons.bell, title: "Notifications"),
            TabData(iconData: CustomIcons.settings, title: "Settings"),
          ],
          onTabChangedListener: (position) {
              Parent.tabController.animateTo(position);
          },
        ));
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7335428, size.height * 6.166667);
    path_0.lineTo(size.width * 0.6716675, size.height * 6.166667);
    path_0.cubicTo(
        size.width * 0.6668460,
        size.height * 6.165000,
        size.width * 0.6621247,
        size.height * 6.155519,
        size.width * 0.6578264,
        size.height * 6.138889);
    path_0.cubicTo(
        size.width * 0.6495232,
        size.height * 6.106019,
        size.width * 0.6430196,
        size.height * 6.052000,
        size.width * 0.6394645,
        size.height * 5.986333);
    path_0.cubicTo(
        size.width * 0.6211149,
        size.height * 5.536741,
        size.width * 0.5453888,
        size.height * 5.406204,
        size.width * 0.5031589,
        size.height * 5.751352);
    path_0.cubicTo(
        size.width * 0.4951418,
        size.height * 5.816870,
        size.width * 0.4891198,
        size.height * 5.894889,
        size.width * 0.4855134,
        size.height * 5.979926);
    path_0.cubicTo(
        size.width * 0.4785550,
        size.height * 6.082907,
        size.width * 0.4652885,
        size.height * 6.152907,
        size.width * 0.4501222,
        size.height * 6.166667);
    path_0.lineTo(size.width * 0.3887531, size.height * 6.166667);
    path_0.lineTo(size.width * 0.3887531, size.height * 5.500000);
    path_0.lineTo(size.width * 0.7335452, size.height * 5.493944);
    path_0.lineTo(size.width * 0.7335428, size.height * 6.166667);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffff3434).withOpacity(1.0);
    canvas.drawShadow(path_0, Colors.black, 3, true);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
