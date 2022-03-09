import 'dart:_http';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class CustomerTypeAPI {
  Dio dio = DioSettings.dio();

  Future<Response> addNewCustomerType(
    String token, {
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await dio.post('/api/custtype/new',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
          }));
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

  Future<Response> getAllCustomerType(String token,
      {Map<String, dynamic>? params}) async {
    Response response;
    try {
      response = await dio.get(
        '/api/custtype/get_all',
        queryParameters: params,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
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
  static final CustomerTypeAPI _instance = CustomerTypeAPI._internal();

  factory CustomerTypeAPI() {
    return _instance;
  }

  CustomerTypeAPI._internal();
}
