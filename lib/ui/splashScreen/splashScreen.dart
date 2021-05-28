import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/service/sp/sp.dart';
import 'package:studenthub2/ui/auth/login/model/login_model.dart';
import 'package:studenthub2/ui/auth/login/view/login.dart';
import 'package:studenthub2/ui/parent/view/parent.dart';
import 'package:studenthub2/ui/university/view/university.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool logo = false;
  bool img = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        img = true;
      });
      Future.delayed(Duration(milliseconds: 1500), () {
        setState(() {
          logo = true;
        });
        goto();
      });
    });
  }

  goto() {
    Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => getHome(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0),
                colors: [
                  const Color(0xff15173b),
                  const Color(0xff1a1c3f),
                  const Color(0xff030519),
                  const Color(0xff808080)
                ],
                stops: [0.0, 0.51, 0.95, 1.0],
              ),
            ),
          ),
          Center(
            child: AnimatedContainer(
              width: !logo ? 0 : MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 50),
              duration: Duration(seconds: 1),
              child: SvgPicture.asset(
                "assets/svg/logo_with_text.svg",
                color: Colors.white,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: img ? 0 : -200,
            duration: Duration(milliseconds: 800),
            child: Image.asset("assets/images/ss_group.png"),
          ),
        ],
      ),
    );
  }

  Widget getHome() {
    LoginModel? loginModel = SPData.spData.getLoginInfo();
    if (loginModel != null) {
      setLoginInfo = loginModel;
    }
    return loginModel == null
        ? SPData.spData.getUniversity() != null
            ? Login()
            : University()
        : Parent();
  }
}