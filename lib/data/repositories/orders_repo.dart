import 'dart:io';

import 'package:delicious_inventory_system/data/models/order_attachment/order_attachment_model.dart';

import '/data/models/orders/order_model.dart';
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
  int _forConfirmationCount = 0;
  int _forDispatchCount = 0;

  OrderModel get order => _order;
  int get forConfirmationCount => _forConfirmationCount;
  int get forDispatchCount => _forDispatchCount;

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
        _instance._forConfirmationCount =
            response.data['count']['for_confirmation'];
        _instance._forDispatchCount = response.data['count']['for_dispatch'];
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<List<OrderAttachmentModel>> fetchAttachments(int orderId) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString("userData")!)["token"];
    List<OrderAttachmentModel> attachments = [];

    try {
      response =
          await _ordersAPI.getOrderAttachmentByOrderId(token, orderId: orderId);
      if (response.statusCode == 200) {
        attachments = List<OrderAttachmentModel>.from(response.data['data']
            .map((e) => OrderAttachmentModel.fromJson(e))).toList();
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return attachments;
  }
}
