import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;
  static String apiKey = 'AIzaSyALie5W9E1zqr1lnX0zfs9hkmwWM-XypQo';

  static init() {
    dio = Dio(BaseOptions(receiveDataWhenStatusError: true))
      ..interceptors.addAll([
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 89,
          ),
      ]);
  }

  static Future<Response> getData({
    required String endPoint,
    String? refreshToken,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      // 'Authorization': 'Bearer ${CacheHelper.get(key: 'accessToken')}',
    };
    final response = await dio!.get(endPoint, queryParameters: query);
    return response;
  }

  static Future<Response<dynamic>> postData({
    required String endPoint,
    dynamic data,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': apiKey,
      // 'Authorization': 'Bearer ${CacheHelper.get(key: 'accessToken')}',
    };
    final response = await dio!.post(endPoint, data: data);
    return response;
  }
}
