import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class DiscountTypeAPI {
  Dio dio = DioSettings.dio();

  Future<Response> getAllDiscType({required String token}) async {
    Dio dio = DioSettings.dio();
    Response response;
    try {
      response = await dio.get(
        '/api/disc_type/get_all',
        options: Options(headers: {
          "Authorization": "Bearer " + token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  ///Singleton factory
  static final DiscountTypeAPI _instance = DiscountTypeAPI._internal();

  factory DiscountTypeAPI() {
    return _instance;
  }

  DiscountTypeAPI._internal();
}
