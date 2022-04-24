part of 'customer_info_bloc.dart';

enum CustomerInfoViewStatus { init, loading, success, error }

class CustomerInfoViewState extends Equatable {
  const CustomerInfoViewState({
    this.fetchingStatus = CustomerInfoViewStatus.init,
    this.fetchedCustomer,
    this.message = '',
  });

  final CustomerInfoViewStatus fetchingStatus;
  final CustomerModel? fetchedCustomer;
  final String message;

  CustomerInfoViewState copyWith({
    CustomerInfoViewStatus? fetchingStatus,
    CustomerModel? fetchedCustomer,
    String? message,
  }) {
    return CustomerInfoViewState(
      fetchingStatus: fetchingStatus ?? this.fetchingStatus,
      fetchedCustomer: fetchedCustomer ?? this.fetchedCustomer,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [fetchingStatus, fetchedCustomer, message];
}
