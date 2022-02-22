import '/data/models/orders/order_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitState extends OrderState {}

class OrderUpdateSubmitting extends OrderState {}

class OrderSuccessfullyUpdated extends OrderState {
  final String message;
  const OrderSuccessfullyUpdated(this.message);
  @override
  List<Object?> get props => [message];
}

class ErrorOrderState extends OrderState {
  final String message;
  const ErrorOrderState(this.message);
  @override
  List<Object> get props => [message];
}

class FetchingOrderState extends OrderState {}

class OrderLoadedState extends OrderState {
  final OrderModel orderModel;
  const OrderLoadedState(this.orderModel);
  @override
  List<Object> get props => [orderModel];
}

class FetchingErrorState extends OrderState {
  final String message;
  const FetchingErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class SalesSubmitting extends OrderState {}

class SalesCreated extends OrderState {
  final String message;
  const SalesCreated(this.message);

  @override
  List<Object> get props => [message];
}

class CreatingSalesError extends OrderState {
  final String message;

  const CreatingSalesError(this.message);

  @override
  List<Object> get props => [message];
}

class OrderCancelSubmitting extends OrderState {}

class OrderCanceledSuccessfully extends OrderState {
  final String message;

  const OrderCanceledSuccessfully(this.message);

  @override
  List<Object> get props => [message];
}

class OrderCancelError extends OrderState {
  final String message;

  const OrderCancelError(this.message);

  @override
  List<Object> get props => [message];
}
