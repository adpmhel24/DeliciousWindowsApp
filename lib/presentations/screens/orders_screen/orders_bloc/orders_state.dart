import 'package:delicious_windows_app/data/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  @override
  List<Object?> get props => [];
}

class OrdersInitialize extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderHeaderModel> orders;
  const OrdersLoaded(this.orders);
  @override
  List<Object> get props => [orders];
}

class ErrorState extends OrdersState {
  final String messsage;
  const ErrorState(this.messsage);

  @override
  List<Object> get props => [messsage];
}
