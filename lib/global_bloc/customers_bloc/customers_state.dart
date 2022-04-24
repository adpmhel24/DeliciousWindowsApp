import 'package:equatable/equatable.dart';

import '/data/models/models.dart';

enum CustomersStateStatus { init, loading, success, error }

class CustomersState extends Equatable {
  final CustomersStateStatus status;
  final List<CustomerModel> customers;
  final String? message;

  const CustomersState({
    this.status = CustomersStateStatus.init,
    this.customers = const [],
    this.message = "",
  });

  CustomersState copyWith({
    CustomersStateStatus? status,
    List<CustomerModel>? customers,
    String? message,
  }) {
    return CustomersState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, customers, message];
}
