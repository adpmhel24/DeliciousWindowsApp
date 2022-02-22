import 'package:delicious_windows_app/data/repositories/repositories.dart';
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
  final double? paidAmount;
  final Map<String, dynamic> data;
  const SubmitCreateSales(this.data, this.paidAmount);
  @override
  List<Object> get props => [data];
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
