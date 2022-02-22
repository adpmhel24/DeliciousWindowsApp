import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_settings.dart';

class OrdersAPI {
  Future<Response> getAllOrders(
      {required String token, Map<String, dynamic>? params}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")).dio();
    try {
      response = await dio.get('/api/ordering/all',
          queryParameters: params,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response!.data['message']);
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> getOrderByID(
      {required String token, required int orderId}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")).dio();
    try {
      response = await dio.get('/api/ordering/get_by_id/$orderId',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
          }));
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response!.data['message']);
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> updateOrderById(int orderId,
      {required String token, required Map<String, dynamic> data}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")).dio();

    try {
      response = await dio.put('/api/ordering/update/$orderId',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT",
            "Content-Type": "application/json",
          }),
          data: data);
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response!.data['message']);
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> cancelOrder(int orderId,
      {required String token, required Map<String, dynamic> data}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = DioSettings(prefs.getString("url")).dio();

    try {
      response = await dio.put('/api/ordering/cancel/$orderId',
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers":
                "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS, GET, PUT",
            "Content-Type": "application/json",
          }),
          data: data);
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response!.data['message']);
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }
}
