import 'package:bhuvan_cv/models/user_details_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../config/config.dart';
import '../exception/APIException.dart';
import '../models/error_api.dart';
import 'logger.dart';

class RestApi {
  static Dio? _dio;

  // ignore: empty_constructor_bodies
  RestApi() {}

  static makeDioNull() {
    _dio = null;
  }

  static Future<Dio> getInstance() async {
    Dio? _dioM;
    if (_dio == null) {
      var value = await SharedPreferences.getInstance();
      var tk = value.getString(Config.USER_ENC_ROLL);
      if (_dioM == null) {
        BaseOptions options = BaseOptions(
          baseUrl: Config.BASE_URL_API,
          receiveDataWhenStatusError: true,
          receiveTimeout: const Duration(seconds: 10),
          connectTimeout: const Duration(seconds: 10),
        );
        // options.headers['Authorization'] = "Bearer " + (tk ?? "");
        options.headers['STUENCID'] = tk;
        _dioM = Dio(options);
        if (kDebugMode) {
          _dioM.interceptors.add(LogInterceptor(
              requestBody: true,
              request: true,
              responseBody: true,
              error: true));
        }
      }
      _dio = _dioM;
    }

    return _dio!;
  }

  Future<dynamic> post(String endPoint, dynamic body,
      {bool isForm = false}) async {
    try {
      var formData = FormData.fromMap({});
      if (isForm) {
        formData = FormData.fromMap(body);
      }
      final _dio = await getInstance();
      Response response = await _dio.post(
        endPoint,
        options: isForm ? Options(contentType: "multipart/form-data") : null,
        data: isForm ? formData : body,
      );
      if (response.statusCode == 200 && response.data != null) {
        LogMe.logInfo("data in post is ${response.data}");
        return response.data;
      } else {
        LogMe.logError("Error code ${response.statusCode}");
        throw APIException(ErrorApi("Something went wrong", 400));
      }
    } catch (e) {
      ErrorApi? errorApi;
      LogMe.logError(e.toString());
      if (e is DioError && e.response != null) {
        errorApi = ErrorApi.fromJson(e.response?.data);
      } else {
        LogMe.logError(e.toString());
        errorApi = ErrorApi("Unable to connect to server", 400);
      }

      throw APIException(errorApi);
    }
  }

  Future<dynamic> get(String endPoint, {dynamic query}) async {
    try {
      LogMe.logInfo("running path $endPoint , with query $query");
      final _dio = await getInstance();
      Response response = await _dio.get(endPoint, queryParameters: query);
      if (response.statusCode == 200 && response.data != null) {
        LogMe.logInfo("data in get is ${response.data}");
        return response.data;
      } else {
        throw APIException(ErrorApi("Something went wrong", 400));
      }
    } catch (e) {
      ErrorApi? errorApi;
      if (e is DioError && e.response != null) {
        errorApi = ErrorApi.fromJson(e.response?.data);
      } else {
        LogMe.logError(e.toString());
        errorApi = ErrorApi("Unable to connect to server", 400);
      }

      throw APIException(errorApi);
    }
  }

  Future<UserDetails?> getUserData(int userId, String tokenSP) async {
    return UserDetails(
      "name",
      "subject line",
      "role",
      "location",
      "https://avatars3.githubusercontent.com/u/26062816?s=400&u=183b286c638a153b03b056b27028dcc16dae4c84&v=4",
      [],
      [],
      []
    );
  }
}
