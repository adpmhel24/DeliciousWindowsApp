part of 'update_add_address_bloc.dart';

enum UpdateAddAddressStateStatus {
  init,
  loading,
  updatedSuccess,
  deletedSuccess,
  addedSuccess,
  error
}

class UpdateAddAddressState extends Equatable {
  const UpdateAddAddressState({
    this.status = UpdateAddAddressStateStatus.init,
    this.customer,
    this.message = '',
  });

  final UpdateAddAddressStateStatus status;
  final CustomerModel? customer;
  final String message;

  UpdateAddAddressState copyWith({
    UpdateAddAddressStateStatus? status,
    CustomerModel? customer,
    String? message,
  }) {
    return UpdateAddAddressState(
      status: status ?? this.status,
      customer: customer ?? this.customer,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        customer,
        message,
      ];
}
