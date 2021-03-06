import 'dart:io';

import 'package:dio/dio.dart';
import '../api_services/apis.dart';
import '../models/models.dart';
import './repositories.dart';

class DiscountTypeRepo {
  final DiscountTypeAPI _discountTypeAPI = DiscountTypeAPI();
  final AuthRepository _authRepository = AuthRepository();

  List<DiscTypeModel> _discTypes = [];

  List<DiscTypeModel> get discTypes => [..._discTypes];

  Future<void> fetchDiscType() async {
    Response response;
    try {
      response = await _discountTypeAPI.getAllDiscType(
          token: _authRepository.currentUser.token);
      if (response.statusCode == 200) {
        _discTypes = List<DiscTypeModel>.from(
            response.data['data'].map((i) => DiscTypeModel.fromJson(i)));
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  List<DiscTypeModel> getSuggestions(String description) {
    return _discTypes
        .where((e) =>
            e.description.toLowerCase().contains(description.toLowerCase()))
        .toList();
  }

  ///Singleton factory
  static final DiscountTypeRepo _instance = DiscountTypeRepo._internal();

  factory DiscountTypeRepo() {
    return _instance;
  }

  DiscountTypeRepo._internal();
}
