import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delicious_inventory_system/data/models/order_attachment/order_attachment_model.dart';
import 'package:delicious_inventory_system/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'order_attachment_event.dart';
part 'order_attachment_state.dart';

class OrderAttachmentBloc
    extends Bloc<OrderAttachmentEvent, OrderAttachmentState> {
  final OrdersRepository _orderRepo = AppRepo.ordersReposistory;
  OrderAttachmentBloc() : super(const OrderAttachmentState()) {
    on<GetOrderAttachment>(_onGetOrderAttachment);
  }

  void _onGetOrderAttachment(
      GetOrderAttachment event, Emitter<OrderAttachmentState> emit) async {
    emit(state.copyWith(status: OrderAttachmentStateStatus.loading));

    try {
      List<OrderAttachmentModel> attachments =
          await _orderRepo.fetchAttachments(event.orderId);
      emit(
        state.copyWith(
          attachments: attachments,
          status: OrderAttachmentStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: OrderAttachmentStateStatus.error,
          message: e.message,
        ),
      );
    }
  }
}
