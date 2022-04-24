import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delicious_inventory_system/data/repositories/app_repo.dart';
import 'package:delicious_inventory_system/data/repositories/customers_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../data/models/models.dart';

part 'customer_info_event.dart';
part 'customer_info_state.dart';

class CustomerInfoViewBloc
    extends Bloc<CustomerInfoViewEvent, CustomerInfoViewState> {
  final CustomersRepo _customersRepo = AppRepo.customersRepository;
  CustomerInfoViewBloc() : super(const CustomerInfoViewState()) {
    on<FetchCustomerInfo>(_onFetchCustomerInfo);
    on<UpdatedCustomerInfo>(_onUpdatedCustomerInfo);
  }

  void _onFetchCustomerInfo(
      FetchCustomerInfo event, Emitter<CustomerInfoViewState> emit) async {
    emit(state.copyWith(fetchingStatus: CustomerInfoViewStatus.loading));

    try {
      CustomerModel customer =
          await _customersRepo.fetchCustomerInfo(event.customerId);
      emit(
        state.copyWith(
          fetchingStatus: CustomerInfoViewStatus.success,
          fetchedCustomer: customer,
        ),
      );
    } on HttpException catch (e) {
      emit(state.copyWith(
          fetchingStatus: CustomerInfoViewStatus.error, message: e.message));
    }
  }

  void _onUpdatedCustomerInfo(
      UpdatedCustomerInfo event, Emitter<CustomerInfoViewState> emit) async {
    emit(
      state.copyWith(
        fetchingStatus: CustomerInfoViewStatus.loading,
      ),
    );

    try {
      emit(
        state.copyWith(
          fetchingStatus: CustomerInfoViewStatus.success,
          fetchedCustomer: event.customer,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          fetchingStatus: CustomerInfoViewStatus.error,
          message: e.message,
        ),
      );
    }
  }
}
