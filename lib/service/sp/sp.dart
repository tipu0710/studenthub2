import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/student_reg.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/auth/login/model/login_model.dart';
import 'package:studenthub2/ui/university/model/university_mode.dart';

class SPData {
  SPData._();
  static SPData spData = SPData._();
  SharedPreferences _sharedPreferences;
  initSP() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  Future<bool> setUniversity(UniversityModel universityModel) async {
    String model = jsonEncode(universityModel.toJson());
    return await _sharedPreferences.setString("UNI", model);
  }

  UniversityModel getUniversity() {
    if (_sharedPreferences.containsKey("UNI")) {
      return UniversityModel.fromJson(
          jsonDecode(_sharedPreferences.getString("UNI")));
    }
    return null;
  }

  Future<void> removeUniversity() async {
    setLoginInfo = null;
    if (_sharedPreferences.containsKey("UNI")) {
      return await _sharedPreferences.remove("UNI");
    }
  }

  Future<bool> setStudentRegInfo(StudentRegModel data) async {
    return await _sharedPreferences.setString(
        "SREG", jsonEncode(data.toJson()));
  }

  StudentRegModel getStudentRegInfo() {
    if (_sharedPreferences.containsKey("SREG")) {
      return StudentRegModel.fromJson(
          jsonDecode(_sharedPreferences.getString("SREG")));
    }
    return null;
  }

  Future<void> removeRegInfo() async {
    setLoginInfo = null;
    if (_sharedPreferences.containsKey("SREG")) {
      return await _sharedPreferences.remove("SREG");
    }
  }

  Future<bool> saveLoginInfo(LoginModel loginModel) async {
    return await _sharedPreferences.setString(
        "LOGIN", DataProcess.getEncryptedData(jsonEncode(loginModel.toJson())));
  }

  Future<void> removeLoginInfo() async {
    setLoginInfo = null;
    if (_sharedPreferences.containsKey("LOGIN")) {
      return await _sharedPreferences.remove("LOGIN");
    }
  }

  LoginModel getLoginInfo() {
    if (_sharedPreferences.containsKey("LOGIN")) {
      return LoginModel.fromJson(jsonDecode(
          DataProcess.getDecryptedData(_sharedPreferences.getString("LOGIN"))));
    }
    return null;
  }

  int getNotificationId(){
    int i;
    if (_sharedPreferences.containsKey("id")) {
      i = _sharedPreferences.getInt("id");
    }else{
      i = -1;
    }
    _sharedPreferences.setInt("id", i++);
    return i;
  }

}
