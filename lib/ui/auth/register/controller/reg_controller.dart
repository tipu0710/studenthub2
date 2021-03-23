import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:studenthub2/service/api/api_service.dart';
import 'package:studenthub2/service/sp/process.dart';
import 'package:studenthub2/ui/auth/model/country_model.dart';

class RegisterController {
  StreamController _streamCountry;

  RegisterController(StreamController streamCountry) {
    _streamCountry = streamCountry;
    _getCountries();
  }

  List<CountryModel> _countryList = <CountryModel>[];

  updateCountryStream(String data) {
    if (data.length < 1) return;
    Iterable list =
        _countryList.where((element) => element.name.contains(data));
    List<CountryModel> finalList = [];
    list.forEach((element) {
      finalList.add(element);
    });
    _streamCountry.add(finalList);
  }

  void _getCountries() async {
    Response response = await ApiService.getMethod(
        "https://studenthub.smartcampus.com.my/api/Home/CountryMobileApi/GetPagedCountry?textkey=&pageSize=-1&pageNo=-1",
        allowToken: false,
        addBaseUrl: false);
    String s = ProcessData.getDecryptedData(response.data['Data']);
    Iterable iterable = jsonDecode(s);
    iterable.forEach((element) {
      _countryList.add(CountryModel.fromJson(element));
    });
    print("data get");
  }
}
