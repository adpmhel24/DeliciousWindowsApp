import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
  @override
  List<Object?> get props => [];
}

class FetchForConfirmationOrders extends OrdersEvent {}

class FetchForDispatchOrders extends OrdersEvent {}

class FetchCompletedOrders extends OrdersEvent {}

class FetchCanceledOrders extends OrdersEvent {}
