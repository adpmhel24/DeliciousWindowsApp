import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_services/apis.dart';
import '../models/models.dart';

class OrderRepository extends ChangeNotifier {
  final OrdersAPI _ordersAPI = OrdersAPI();
  late OrderModel _order;
  List<CommentModel> _comments = [];

  List<CommentModel> get comments => [..._comments];

  OrderModel get order => _order;

  Future<bool> fetchOrderById(int orderId) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString("userData")!)["token"];
    try {
      response = await _ordersAPI.getOrderByID(token: token, orderId: orderId);
      if (response.statusCode == 200) {
        _order = OrderModel.fromJson(response.data['data']);
        notifyListeners();
        return true;
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<void> fetchCommentByOrderId(int orderId) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString("userData")!)["token"];
    try {
      response = await _ordersAPI.getCommentByOrderId(token, orderId: orderId);
      if (response.statusCode == 200) {
        _comments = List<CommentModel>.from(
          response.data['data'].map(
            (comment) => CommentModel.fromJson(comment),
          ),
        );
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<String> updateOrderById(
      {required int orderId, required Map<String, dynamic> data}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString("userData")!)["token"];
    try {
      response =
          await _ordersAPI.updateOrderById(orderId, token: token, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['message'];
      } else {
        throw HttpException(response.data['message']);
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<String> cancelOrder(
      {required int orderId, required Map<String, dynamic> data}) async {
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString("userData")!)["token"];
    String message = "";
    try {
      response =
          await _ordersAPI.cancelOrder(orderId, token: token, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        message = response.data["message"];
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return message;
  }

  void updatePaidAmount(double value) {
    order.balance = order.doctotal! - value;
    order.paidAmount = value;
    notifyListeners();
  }

  void updateDeliverFee(double value) {
    order.delfee = value;
    order.doctotal =
        (order.subtotal ?? 0) + (order.delfee ?? 0) + (order.otherfee ?? 0);
    order.balance = (order.doctotal ?? 0) - (order.paidAmount ?? 0);
    notifyListeners();
  }

  void updateOtherFee(double value) {
    order.otherfee = value;
    order.doctotal =
        (order.subtotal ?? 0) + (order.delfee ?? 0) + (order.otherfee ?? 0);
    order.balance = (order.doctotal ?? 0) - (order.paidAmount ?? 0);
    notifyListeners();
  }

  void updateDiscountPercentage(int rowId, double value) {
    var orderRow = order.rows[rowId];
    double gross = orderRow.quantity * orderRow.unitPrice;
    double discAmnt = (value / 100) * gross;

    order.rows[rowId].discAmount = double.parse(discAmnt.toStringAsFixed(2));
    order.rows[rowId].subtotal =
        double.parse((gross - discAmnt).toStringAsFixed(2));
    double headerSubtotal = 0;
    for (OrderRowModel row in order.rows) {
      headerSubtotal += row.subtotal ?? 0;
    }
    order.subtotal = headerSubtotal;
    order.doctotal = headerSubtotal + order.otherfee! + order.delfee!;
    order.balance = order.doctotal;
    notifyListeners();
  }

  void updateDiscountAmount(int rowId, double value) {
    var orderRow = order.rows[rowId];
    double gross = orderRow.quantity * orderRow.unitPrice;
    double discPercentage = (value / gross) * 100;

    order.rows[rowId].discprcnt =
        double.parse(discPercentage.toStringAsFixed(2));
    order.rows[rowId].subtotal =
        double.parse((gross - value).toStringAsFixed(2));
    double headerSubtotal = 0;
    for (OrderRowModel row in order.rows) {
      headerSubtotal += row.subtotal ?? 0;
    }
    order.subtotal = headerSubtotal;
    order.doctotal = headerSubtotal + order.otherfee! + order.delfee!;
    order.balance = order.doctotal;
    notifyListeners();
  }

  void updateHeader(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (key == 'dispatchingWhse') {
        _order.dispatchingWhse = value;
        notifyListeners();
      } else if (key == 'salestype') {
        _order.salestype = value;
        notifyListeners();
      } else if (key == 'disctype') {
        _order.disctype = value;
        notifyListeners();
      } else if (key == 'orderStatus') {
        _order.orderStatus = value;
        notifyListeners();
      } else if (key == 'remarks') {
        _order.remarks = value;
        notifyListeners();
      }
    });
  }
}
