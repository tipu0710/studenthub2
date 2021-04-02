import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:studenthub2/ui/auth/login/model/login_model.dart';
import 'package:studenthub2/ui/home/model/home_model.dart';

import 'ui/profile/model/profile_model.dart';

extension StringExtension on String {
  String capitalize() {
    String string = '';
    var s = this.split(' ');
    s.forEach((element) {
      string += "${element[0].toUpperCase()}${element.substring(1)} ";
    });
    return string.trim();
  }
}

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
set setProfile(ProfileModel profileModel) => _profileModel = profileModel;
ProfileModel get profileModel => _profileModel;

GeneralInstitute _institute;
set setInstitute(GeneralInstitute institute) => _institute = institute;
GeneralInstitute get institute => _institute;

enum DateType { date, time, dateTime }

String dateTimeFormatter(String date, {DateType dateType = DateType.dateTime}) {
  var splitedDateTime = date.split('T');
  var splitedDate = splitedDateTime.first.split('-');
  var formattedDate =
      splitedDate.last + '-' + splitedDate[1] + '-' + splitedDate.first;
  var splitedTime = splitedDateTime.last.split(':');
  splitedTime.last = splitedTime.last.split('.').first;
  var formattedTime = '';
  int hour = int.parse(splitedTime.first);
  String minute = splitedTime[1];
  String second = splitedTime.last;
  var type = "";
  if (hour == 0) {
    formattedTime = "12";
    type = "AM";
  } else if (hour == 12) {
    formattedTime = "12";
    type = "PM";
  } else if (hour > 12) {
    type = "PM";
    String s = (hour - 12).toString();
    formattedTime = s.length == 2 ? s : "0$s";
  } else {
    type = "AM";
    String s = hour.toString();
    formattedTime = s.length == 2 ? s : "0$s";
  }
  formattedTime = formattedTime + ':' + minute + ':' + second + ' $type';

  switch (dateType) {
    case DateType.dateTime:
      return formattedDate + ' ' + formattedTime;
      break;
    case DateType.time:
      return formattedTime;
      break;
    case DateType.date:
      return formattedDate;
      break;
    default:
      return date;
      break;
  }
}
