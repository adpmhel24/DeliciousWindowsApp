import 'dart:io';

import 'package:dio/dio.dart';
import '../api_services/apis.dart';
import './repositories.dart';

class SalesRepo {
  final SalesAPI _salesAPI = SalesAPI();
  final AuthRepository _authRepository = AuthRepository();

  Future<String> createSales(Map<String, dynamic> data) async {
    Response response;
    String message = "";
    try {
      response = await _salesAPI.createSales(
          token: _authRepository.currentUser.token, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        message = "Sales Ref#: ${response.data['data']['reference']}";
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  ///Singleton factory
  static final SalesRepo _instance = SalesRepo._internal();

  factory SalesRepo() {
    return _instance;
  }

  SalesRepo._internal();
}
