import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:studenthub2/global.dart';
import 'package:studenthub2/model/data_model.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/process/process.dart';
import 'package:studenthub2/ui/profile/model/profile_model.dart';

class ProfileController {
  static getProfile() async {
    Response response = await ApiService.getMethod(
        "/StudentProfileMobileApi/GetStudentProfile");
    DataModel dataModel = DataModel.fromJson(response.data);
    if (dataModel.hasError) {
      showMessage(dataModel.errors.first);
    } else {
      ProfileModel profileModel = ProfileModel.fromJson(
          jsonDecode(DataProcess.getDecryptedData(dataModel.data)));
      InstitutionDetails institutionDetails =
          InstitutionDetails.fromJson(dataModel.dataExtra);
      profileModel.institutionDetails = institutionDetails;
      setProfile = profileModel;
    }
  }
}
