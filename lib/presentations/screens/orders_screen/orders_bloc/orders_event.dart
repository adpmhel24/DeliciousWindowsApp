import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
  @override
  List<Object?> get props => [];
}

class FetchForConfirmationOrders extends OrdersEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const FetchForConfirmationOrders([this.startDate, this.endDate]);
}

class FetchForDispatchOrders extends OrdersEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  const FetchForDispatchOrders([this.startDate, this.endDate]);
}

class FetchCompletedOrders extends OrdersEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  const FetchCompletedOrders([this.startDate, this.endDate]);
}

class FetchCanceledOrders extends OrdersEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  const FetchCanceledOrders([this.startDate, this.endDate]);
}
