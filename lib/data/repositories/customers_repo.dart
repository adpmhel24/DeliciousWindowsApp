import 'dart:io';

import 'package:delicious_inventory_system/data/api_services/apis.dart';
import 'package:dio/dio.dart';

import '../models/models.dart';
import 'repositories.dart';

class CustomersRepo {
  final CustomerAPI _customerAPI = CustomerAPI();
  final String _token = AuthRepository().currentUser.token;

  List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => [..._customers];

  Future<void> fetchAllCustomers(Map<String, dynamic>? params) async {
    Response response;
    try {
      response = await _customerAPI.getAllCustomer(_token, params: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _customers = List<CustomerModel>.from(
          response.data['data'].map(
            (e) => CustomerModel.fromJson(e),
          ),
        );
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<String> createNewCustomer(Map<String, dynamic> data) async {
    Response response;
    try {
      response = await _customerAPI.addNewCustomer(_token, data: data);
      return response.data['message'];
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<String> addNewCustomerAddress({
    required int customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await _customerAPI.addNewCustomerAddress(_token,
          customerId: customerId, data: data);
      return response.data['message'];
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  ///Singleton factory
  static final CustomersRepo _instance = CustomersRepo._internal();

  factory CustomersRepo() {
    return _instance;
  }

  CustomersRepo._internal();
}
