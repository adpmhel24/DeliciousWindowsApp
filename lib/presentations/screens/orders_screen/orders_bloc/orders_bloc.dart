import 'dart:io';

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
        if (event.startDate != null)
          "from_date":
              DateFormat('MM/dd/yyy').format(event.startDate!).toString(),
        if (event.endDate != null)
          "to_date": DateFormat('MM/dd/yyy').format(event.endDate!).toString()
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
        if (event.startDate != null)
          "from_date":
              DateFormat('MM/dd/yyy').format(event.startDate!).toString(),
        if (event.endDate != null)
          "to_date": DateFormat('MM/dd/yyy').format(event.endDate!).toString(),
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
        if (event.startDate != null)
          "from_date":
              DateFormat('MM/dd/yyy').format(event.startDate!).toString(),
        if (event.endDate != null)
          "to_date": DateFormat('MM/dd/yyy').format(event.endDate!).toString(),
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
          if (event.startDate != null)
            "from_date":
                DateFormat('MM/dd/yyy').format(event.startDate!).toString(),
          if (event.endDate != null)
            "to_date":
                DateFormat('MM/dd/yyy').format(event.endDate!).toString(),
        },
      );
      emit(OrdersLoaded(_ordersRepository.orders));
    } on HttpException catch (e) {
      emit(ErrorState(e.message));
    }
  }
}
