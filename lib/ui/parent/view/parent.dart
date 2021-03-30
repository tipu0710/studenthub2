import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/ui/calender/controller/event_notification.dart';
import 'package:studenthub2/ui/home/view/home.dart';
import 'package:studenthub2/ui/notification/view/notification.dart';
import 'package:studenthub2/ui/profile/view/profile.dart';
import 'package:studenthub2/ui/qr/view/qr_parent.dart';
import 'package:studenthub2/ui/settings/view/settings.dart';
import 'package:studenthub2/ui_helper/custom_icons.dart';
import 'package:studenthub2/ui_helper/nav/fancy_bottom_navigation.dart';

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
    setContext = context;
    requestPermissions();
    configureDidReceiveLocalNotificationSubject();
    configureSelectNotificationSubject();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(Parent.tabController.index != 0){
          Parent.tabController.animateTo(0);
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
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
          )),
    );
  }
}
