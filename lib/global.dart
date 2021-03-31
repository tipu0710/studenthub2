import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:studenthub2/ui/auth/login/model/login_model.dart';
import 'package:studenthub2/ui/home/model/home_model.dart';

import 'ui/profile/model/profile_model.dart';

const MaterialColor primaryColor = const MaterialColor(
  0xFF1e5aa7,
  const <int, Color>{
    50: const Color(0xFF1e5aa7),
    100: const Color(0xFF1e5aa7),
    200: const Color(0xFF1e5aa7),
    300: const Color(0xFF1e5aa7),
    400: const Color(0xFF1e5aa7),
    500: const Color(0xFF1e5aa7),
    600: const Color(0xFF1e5aa7),
    700: const Color(0xFF1e5aa7),
    800: const Color(0xFF1e5aa7),
    900: const Color(0xFF1e5aa7),
  },
);

showMessage(String message,
    {Color backgroundColor = primaryColor,
    ToastPosition toastPosition = ToastPosition.bottom,
    Color textColor = Colors.white,
    double fontSize = 16.0}) {
  showToast(
    message,
    duration: Duration(seconds: 3),
    position: toastPosition,
    backgroundColor: backgroundColor.withOpacity(0.8),
    radius: 3.0,
    textStyle: TextStyle(fontSize: fontSize, color: textColor),
  );
}

LoginModel _loginModel;
set setLoginInfo(LoginModel loginModel) => _loginModel = loginModel;
LoginModel get loginInfo => _loginModel;

ProfileModel _profileModel;
set setProfile(ProfileModel profileModel)=>_profileModel = profileModel;
ProfileModel get profileModel => _profileModel;

Institute _institute;
set setInstitute(Institute institute)=>_institute = institute;
Institute get institute => _institute;

