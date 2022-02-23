import 'dart:io';

import 'package:delicious_windows_app/data/api_services/apis.dart';
import 'package:delicious_windows_app/data/models/models.dart';
import 'package:dio/dio.dart';

import 'repositories.dart';

class WarehouseRepo {
  late List<WarehouseModel> _whses = [];
  final WarehouseAPI _warehouseAPI = WarehouseAPI();
  final AuthRepository _authRepository = AppRepo.authRepository;

  List<WarehouseModel> get whses => [..._whses];

  Future<void> fetchWarehouses([Map<String, dynamic>? params]) async {
    Response response;

    try {
      response = await _warehouseAPI.getAllWarehouse(
          token: _authRepository.currentUser.token, params: params);
      if (response.statusCode == 200) {
        _whses = List<WarehouseModel>.from(
            response.data['data'].map((i) => WarehouseModel.fromJson(i)));
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  ///Singleton factory
  static final WarehouseRepo _instance = WarehouseRepo._internal();

  factory WarehouseRepo() {
    return _instance;
  }

  WarehouseRepo._internal();
}
