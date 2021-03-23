import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studenthub2/ui/university/model/university_mode.dart';

class SPData {
  SPData._();
  static SPData spData = SPData._();
  SharedPreferences sharedPreferences;
  initSP() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  Future<bool> setUniversity(UniversityModel universityModel) async {
    String model = jsonEncode(universityModel.toJson());
    return await sharedPreferences.setString("UNI", model);
  }

  Future<UniversityModel> getUniversity() async {
    if (sharedPreferences.containsKey("UNI")) {
      return UniversityModel.fromJson(
          jsonDecode(sharedPreferences.getString("UNI")));
    }
    return null;
  }
}
