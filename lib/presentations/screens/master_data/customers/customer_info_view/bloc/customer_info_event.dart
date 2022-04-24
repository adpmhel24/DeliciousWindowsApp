part of 'customer_info_bloc.dart';

abstract class CustomerInfoViewEvent extends Equatable {
  const CustomerInfoViewEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomerInfo extends CustomerInfoViewEvent {
  final int customerId;
  const FetchCustomerInfo(this.customerId);
  @override
  List<Object> get props => [customerId];
}

class UpdatedCustomerInfo extends CustomerInfoViewEvent {
  final CustomerModel customer;

  const UpdatedCustomerInfo(this.customer);

  @override
  List<Object> get props => [customer];
}
