import 'dart:io';

import 'package:delicious_windows_app/data/api_services/dio_settings.dart';
import 'package:dio/dio.dart';

class SalesAPI {
  final Dio dio = DioSettings.dio();

  Future<Response> createSales(
      {required String token, required Map<String, dynamic> data}) async {
    Response response;

    try {
      response = await dio.post('/api/sales/new',
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
}
