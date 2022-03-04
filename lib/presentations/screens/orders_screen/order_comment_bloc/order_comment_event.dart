import 'package:equatable/equatable.dart';

abstract class OrderCommentEvent extends Equatable {
  const OrderCommentEvent();
  @override
  List<Object?> get props => [];
}

class FetchCommentById extends OrderCommentEvent {
  final int orderId;
  const FetchCommentById(this.orderId);
  @override
  List<Object?> get props => [orderId];
}
