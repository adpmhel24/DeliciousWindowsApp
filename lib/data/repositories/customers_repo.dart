import 'dart:io';

import 'package:delicious_inventory_system/data/api_services/apis.dart';
import 'package:dio/dio.dart';

import '../models/models.dart';
import 'repositories.dart';

class CustomersRepo {
  final CustomerAPI _customerAPI = CustomerAPI();
  final CustomerTypesRepo _custTypes = AppRepo.customerTypeRepository;
  final String _token = AuthRepository().currentUser.token;

  List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => [..._customers];

  Future<void> fetchAllCustomers([Map<String, dynamic>? params]) async {
    Response response;
    try {
      response = await _customerAPI.getAllCustomer(_token, params: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _customers = List<CustomerModel>.from(
          response.data['data'].map((e) {
            e['custTypeName'] = _custTypes.getCustTypeNameById(e['cust_type']);
            return CustomerModel.fromJson(e);
          }),
        );
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<CustomerModel> fetchCustomerInfo(int customerId) async {
    Response response;
    try {
      response = await _customerAPI.fetchCustomerInfo(_token, customerId);
      return CustomerModel.fromJson(response.data['data']);
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

  Future<CustomerModel> addNewCustomerAddress({
    required int customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await _customerAPI.addNewCustomerAddress(_token,
          customerId: customerId, data: data);
      return CustomerModel.fromJson(response.data['data']);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<CustomerModel> updateCustomerAddress({
    required int customerAddressId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await _customerAPI.updateCustomerAddress(_token,
          customerAddressId: customerAddressId, data: data);
      return CustomerModel.fromJson(response.data['data']);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<CustomerModel> deleteCustomerAddress({
    required int customerAddressId,
  }) async {
    Response response;
    try {
      response = await _customerAPI.deleteCustomerAddress(_token,
          customerAddressId: customerAddressId);
      return CustomerModel.fromJson(response.data['data']);
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  List<CustomerModel> filterCustomer(String name, [int? custType]) {
    if ((custType == null || custType < 0) && name.isNotEmpty) {
      return _customers
          .where(
            (e) => (e.name!.toLowerCase().contains(name.toLowerCase()) ||
                e.code!.toLowerCase().contains(name.toLowerCase())),
          )
          .toList();
    } else if (name.isNotEmpty && custType! > 0) {
      return _customers
          .where((e) =>
              (e.name!.toLowerCase().contains(name.toLowerCase()) ||
                  e.code!.toLowerCase().contains(name.toLowerCase())) &&
              e.custType == custType)
          .toList();
    } else if (name.isEmpty && custType != null && custType > 0) {
      return _customers.where((e) => e.custType == custType).toList();
    }
    return [];
  }

  Future<CustomerModel> updateCustomer(
      {required int customerId, required Map<String, dynamic> data}) async {
    Response response;
    try {
      response = await _customerAPI.updateCustomer(_token,
          customerId: customerId, data: data);
      return CustomerModel.fromJson(response.data['data']);
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
