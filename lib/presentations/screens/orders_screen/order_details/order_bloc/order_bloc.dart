import 'dart:io';

import '/data/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitState()) {
    on<SubmitUpdateOrder>(_onSubmitUpdateOrder);
    on<FetchOrderDetails>(_onFetchOrderDetails);
    on<SubmitCreateSales>(_onSubmitCreateSales);
    on<SubmitCancelOrder>(_onSubmitCancelOrder);
  }

  void _onSubmitUpdateOrder(
      SubmitUpdateOrder event, Emitter<OrderState> emit) async {
    emit(OrderUpdateSubmitting());
    try {
      String message = await event.orderRepo
          .updateOrderById(orderId: event.orderId, data: event.data);
      emit(OrderSuccessfullyUpdated(message));
    } on HttpException catch (e) {
      emit(ErrorOrderState(e.message));
    }
  }

  void _onSubmitCreateSales(
      SubmitCreateSales event, Emitter<OrderState> emit) async {
    final SalesRepo salesRepo = AppRepo.salesRepository;
    final OrderRepository orderRepo = OrderRepository();
    emit(SalesSubmitting());
    try {
      await orderRepo.updateOrderById(
          orderId: event.salesData['header']['base_id'], data: event.orderData);
      String message = await salesRepo.createSales(event.salesData);
      emit(SalesCreated(message));
    } on HttpException catch (e) {
      emit(CreatingSalesError(e.message));
    }
  }

  void _onSubmitCancelOrder(
      SubmitCancelOrder event, Emitter<OrderState> emit) async {
    emit(OrderCancelSubmitting());
    try {
      String message = await event.orderRepo
          .cancelOrder(orderId: event.orderId, data: event.data);
      emit(OrderCanceledSuccessfully(message));
    } on HttpException catch (e) {
      emit(OrderCancelError(e.message));
    }
  }

  void _onFetchOrderDetails(
      FetchOrderDetails event, Emitter<OrderState> emit) async {
    final OrderRepository orderRepository = OrderRepository();
    emit(FetchingOrderState());
    try {
      await orderRepository.fetchOrderById(event.orderId);
      emit(OrderLoadedState(orderRepository.order));
    } on HttpException catch (e) {
      emit(FetchingErrorState(e.message));
    }
  }
}
