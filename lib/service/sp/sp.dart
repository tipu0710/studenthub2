import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub2/model/student_reg.dart';
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
}
