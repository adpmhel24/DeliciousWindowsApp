import '/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object?> get props => [];
}

class SubmitUpdateOrder extends OrderEvent {
  final int orderId;
  final Map<String, dynamic> data;
  final OrderRepository orderRepo;
  const SubmitUpdateOrder(
      {required this.orderId, required this.data, required this.orderRepo});
  @override
  List<Object?> get props => [orderId, data];
}

class SubmitCreateSales extends OrderEvent {
  final Map<String, dynamic> orderData;
  final Map<String, dynamic> salesData;
  const SubmitCreateSales({required this.salesData, required this.orderData});
  @override
  List<Object> get props => [salesData, orderData];
}

class SubmitCancelOrder extends OrderEvent {
  final int orderId;
  final Map<String, dynamic> data;
  final OrderRepository orderRepo;
  const SubmitCancelOrder(
      {required this.orderId, required this.data, required this.orderRepo});
  @override
  List<Object> get props => [orderId, data, orderRepo];
}

class FetchOrderDetails extends OrderEvent {
  final int orderId;

  const FetchOrderDetails(this.orderId);

  @override
  List<Object> get props => [orderId];
}
