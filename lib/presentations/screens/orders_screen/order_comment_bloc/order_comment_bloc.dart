import 'dart:io';

import '/data/repositories/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class OrderCommentBloc extends Bloc<OrderCommentEvent, OrderCommentState> {
  final OrderRepository _orderRepository = OrderRepository();

  OrderCommentBloc() : super(const OrderCommentState()) {
    on<FetchCommentById>(_onFetchCommentById);
  }

  void _onFetchCommentById(
      FetchCommentById event, Emitter<OrderCommentState> emit) async {
    emit(state.copyWith(status: OrderCommentStatus.loading));
    try {
      await _orderRepository.fetchCommentByOrderId(event.orderId);
      emit(state.copyWith(
          status: OrderCommentStatus.success,
          orderComments: _orderRepository.comments));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: OrderCommentStatus.failed, message: e.message));
    }
  }
}
