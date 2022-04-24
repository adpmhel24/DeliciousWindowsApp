import 'package:equatable/equatable.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();
  @override
  List<Object?> get props => [];
}

class FetchCustomerFromLocal extends CustomersEvent {}

class FetchCustomerFromAPI extends CustomersEvent {}

class FilterCustomer extends CustomersEvent {
  final String keyword;
  final int? custType;

  const FilterCustomer(this.keyword, [this.custType]);
  @override
  List<Object?> get props => [keyword];
}

class FilterCustomerByCustType extends CustomersEvent {
  final int custType;
  const FilterCustomerByCustType(this.custType);
  @override
  List<Object?> get props => [custType];
}
