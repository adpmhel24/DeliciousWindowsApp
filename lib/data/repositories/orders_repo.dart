import 'dart:io';

import 'package:delicious_windows_app/data/models/orders/order_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api_services/apis.dart';
import '../models/orders/order_header/order_header_model.dart';

class OrdersRepository {
  final OrdersAPI _ordersAPI = OrdersAPI();

  List<OrderHeaderModel> _orders = [];
  List<OrderHeaderModel> get orders => [..._orders];

  late OrderModel _order;
  OrderModel get order => _order;

  ///Singleton factory
  static final OrdersRepository _instance = OrdersRepository._internal();

  factory OrdersRepository() {
    return _instance;
  }

  OrdersRepository._internal();

  Future<void> fetchOrders({Map<String, dynamic>? params}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString("userData")!)["token"];
    try {
      response = await _ordersAPI.getAllOrders(token: token, params: params);
      if (response.statusCode == 200) {
        _instance._orders = List<OrderHeaderModel>.from(
          response.data['data'].map(
            (i) => OrderHeaderModel.fromJson(i),
          ),
        );
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }
}
