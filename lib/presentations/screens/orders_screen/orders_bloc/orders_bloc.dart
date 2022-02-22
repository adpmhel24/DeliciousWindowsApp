import 'dart:io';

import 'package:delicious_windows_app/presentations/screens/orders_screen/order_details/order_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '/data/repositories/repositories.dart';
import 'blocs.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _ordersRepository = AppRepo.ordersReposistory;
  OrdersBloc() : super(OrdersInitialize()) {
    on<FetchForConfirmationOrders>(_onFetchForConfirmationOrders);
    on<FetchForDispatchOrders>(_onFetchForDispatchOrders);
    on<FetchCompletedOrders>(_onFetchCompletedOrders);
    on<FetchCanceledOrders>(_onFetchCanceledOrders);
  }

  void _onFetchForConfirmationOrders(
      FetchForConfirmationOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());

    try {
      await _ordersRepository.fetchOrders(params: {
        "order_status": 0,
        "from_date": DateFormat('MM/dd/yyy')
            .format(event.startDate ?? DateTime.now())
            .toString(),
        "to_date": DateFormat('MM/dd/yyy')
            .format(
                event.endDate ?? DateTime.now().add(const Duration(days: 7)))
            .toString()
      });
      emit(OrdersLoaded(_ordersRepository.orders));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }

  void _onFetchForDispatchOrders(
      FetchForDispatchOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());

    try {
      await _ordersRepository.fetchOrders(params: {
        "order_status": 1,
        "from_date": DateFormat('MM/dd/yyy')
            .format(event.startDate ?? DateTime.now())
            .toString(),
        "to_date": DateFormat('MM/dd/yyy')
            .format(
                event.endDate ?? DateTime.now().add(const Duration(days: 7)))
            .toString()
      });
      emit(OrdersLoaded(_ordersRepository.orders));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }

  void _onFetchCompletedOrders(
      FetchCompletedOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());

    try {
      await _ordersRepository.fetchOrders(params: {
        "docstatus": "C",
        "from_date": DateFormat('MM/dd/yyy')
            .format(event.startDate ?? DateTime.now())
            .toString(),
        "to_date": DateFormat('MM/dd/yyy')
            .format(
                event.endDate ?? DateTime.now().add(const Duration(days: 7)))
            .toString()
      });
      emit(OrdersLoaded(_ordersRepository.orders));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }

  void _onFetchCanceledOrders(
      FetchCanceledOrders event, Emitter<OrdersState> emit) async {
    emit(OrdersLoading());

    try {
      await _ordersRepository.fetchOrders(
        params: {
          "docstatus": "N",
          "from_date": DateFormat('MM/dd/yyy')
              .format(event.startDate ?? DateTime.now())
              .toString(),
          "to_date": DateFormat('MM/dd/yyy')
              .format(
                  event.endDate ?? DateTime.now().add(const Duration(days: 7)))
              .toString(),
        },
      );
      emit(OrdersLoaded(_ordersRepository.orders));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }
}
