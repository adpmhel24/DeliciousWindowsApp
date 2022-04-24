import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/models.dart';
import 'bloc.dart';
import '/data/repositories/repositories.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final CustomersRepo _customerRepo = AppRepo.customersRepository;

  CustomersBloc() : super(const CustomersState()) {
    on<FetchCustomerFromLocal>(onFetchFromLocal);
    on<FetchCustomerFromAPI>(onFetchFromAPI);
    on<FilterCustomer>(onFilterCustomer);
  }

  void onFetchFromLocal(
      FetchCustomerFromLocal event, Emitter<CustomersState> emit) async {
    emit(state.copyWith(status: CustomersStateStatus.loading));
    try {
      if (_customerRepo.customers.isEmpty) {
        await _customerRepo.fetchAllCustomers();
      }
      emit(
        state.copyWith(
          customers: _customerRepo.customers,
          status: CustomersStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: CustomersStateStatus.error,
        ),
      );
    }
  }

  void onFetchFromAPI(
      FetchCustomerFromAPI event, Emitter<CustomersState> emit) async {
    emit(state.copyWith(status: CustomersStateStatus.loading));
    try {
      await _customerRepo.fetchAllCustomers();
      emit(
        state.copyWith(
          customers: _customerRepo.customers,
          status: CustomersStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: CustomersStateStatus.error,
        ),
      );
    }
  }

  void onFilterCustomer(
      FilterCustomer event, Emitter<CustomersState> emit) async {
    emit(state.copyWith(status: CustomersStateStatus.loading));
    try {
      List<CustomerModel> customers =
          _customerRepo.filterCustomer(event.keyword, event.custType);

      emit(
        state.copyWith(
          customers: customers.isEmpty ? _customerRepo.customers : customers,
          status: CustomersStateStatus.success,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: CustomersStateStatus.error,
        ),
      );
    }
  }
}
