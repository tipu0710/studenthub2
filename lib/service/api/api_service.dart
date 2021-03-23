import 'package:dio/dio.dart';

class ApiService {
  static String baseUrl = "http://studenthub.smartcampus.com.my";

  static Future<Response> postMethod(String endPoints,
      {Map<String, dynamic> map,
        bool allowToken = true,
        bool allowFullUrl = true}) async {
    Dio dio = new Dio();
    // if (allowToken) {
    //   dio.options.headers['Content-Type'] = 'application/json';
    //   dio.options.headers['Authorization'] =
    //   'Token ${locator.get<AuthModel>().key}';
    // }

    try {
      Response response = await dio.post(
        allowFullUrl ? _fullUrl(endPoints) : endPoints,
        data: map,
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
      } else {
        print(e.request);
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
    // if (allowToken) {
    //   dio.options.headers['Authorization'] =
    //   'Token ${locator.get<AuthModel>().key}';
    // }
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
        print(e.request);
        print(e.message);
      }
      throw e;
    }
  }

  static String _fullUrl(String url) {
    return baseUrl + "/api/v1" + url;
  }
}
