import 'package:dio/dio.dart';
import 'package:studenthub2/global.dart';

class ApiService {
  static String baseUrl = "https://studenthub.smartcampus.com.my";

  static Future<Response> postMethod(String endPoints,
      {Map<String, dynamic> map,
      bool allowToken = true,
      bool allowFullUrl = true}) async {
    Dio dio = new Dio();
    if (allowToken && loginInfo != null) {
      dio.options.headers['Authorization'] = 'Bearer ${loginInfo.token}';
    }
    try {
      Response response =
          await dio.post(allowFullUrl ? _fullUrl(endPoints) : endPoints);
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.message);
      }
      throw e;
    }
  }

  static Future<Response> getMethod(String endPoints,
      {Map<String, dynamic> map,
      bool addBaseUrl,
      bool allowToken = true}) async {
    Dio dio = new Dio();
    if (allowToken && loginInfo != null) {
      dio.options.headers['Authorization'] = 'Bearer ${loginInfo.token}';
    }
    try {
      Response response;
      if (map != null) {
        response = await dio.get(
            addBaseUrl != null && !addBaseUrl ? endPoints : _fullUrl(endPoints),
            queryParameters: map);
      } else {
        response = await dio.get(addBaseUrl != null && !addBaseUrl
            ? endPoints
            : _fullUrl(endPoints));
      }

      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.message);
      }
      throw e;
    }
  }

  static String _fullUrl(String url) {
    return baseUrl + "/api/Home" + url;
  }
}
