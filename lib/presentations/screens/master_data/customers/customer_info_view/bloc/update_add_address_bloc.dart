import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delicious_inventory_system/data/models/models.dart';
import 'package:delicious_inventory_system/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'update_add_address_event.dart';
part 'update_add_address_state.dart';

class UpdateAddAddressBloc
    extends Bloc<UpdateAddAddressEvent, UpdateAddAddressState> {
  final CustomersRepo _custRepo = AppRepo.customersRepository;
  UpdateAddAddressBloc() : super(const UpdateAddAddressState()) {
    on<AddNewAddressSubmitted>(_onAddNewAddressSubmitted);
    on<UpdateAddressSubmitted>(_onUpdateAddressSubmitted);
    on<DeleteAddressSubmitted>(_onDeleteAddressSubmitted);
  }

  void _onAddNewAddressSubmitted(
      AddNewAddressSubmitted event, Emitter<UpdateAddAddressState> emit) async {
    emit(state.copyWith(status: UpdateAddAddressStateStatus.loading));
    try {
      CustomerModel _customer = await _custRepo.addNewCustomerAddress(
          customerId: event.customerId, data: event.data);

      emit(
        state.copyWith(
          status: UpdateAddAddressStateStatus.addedSuccess,
          customer: _customer,
          message: "Successfully added!",
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: UpdateAddAddressStateStatus.error,
          message: e.message,
        ),
      );
    }
  }

  void _onUpdateAddressSubmitted(
      UpdateAddressSubmitted event, Emitter<UpdateAddAddressState> emit) async {
    emit(state.copyWith(status: UpdateAddAddressStateStatus.loading));
    try {
      CustomerModel _customer = await _custRepo.updateCustomerAddress(
          customerAddressId: event.addressId, data: event.data);

      emit(
        state.copyWith(
            status: UpdateAddAddressStateStatus.updatedSuccess,
            customer: _customer,
            message: "Successfully updated!"),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: UpdateAddAddressStateStatus.error,
          message: e.message,
        ),
      );
    }
  }

  void _onDeleteAddressSubmitted(
      DeleteAddressSubmitted event, Emitter<UpdateAddAddressState> emit) async {
    emit(state.copyWith(status: UpdateAddAddressStateStatus.loading));
    try {
      CustomerModel _customer = await _custRepo.deleteCustomerAddress(
          customerAddressId: event.addressId);

      emit(
        state.copyWith(
            status: UpdateAddAddressStateStatus.deletedSuccess,
            customer: _customer,
            message: "Successfully deleted!"),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: UpdateAddAddressStateStatus.error,
          message: e.message,
        ),
      );
    }
  }
}
