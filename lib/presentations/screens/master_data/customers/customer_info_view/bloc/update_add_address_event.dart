part of 'update_add_address_bloc.dart';

abstract class UpdateAddAddressEvent extends Equatable {
  const UpdateAddAddressEvent();

  @override
  List<Object> get props => [];
}

class AddNewAddressSubmitted extends UpdateAddAddressEvent {
  final int customerId;
  final Map<String, dynamic> data;

  const AddNewAddressSubmitted(this.customerId, this.data);

  @override
  List<Object> get props => [];
}

class UpdateAddressSubmitted extends UpdateAddAddressEvent {
  final int addressId;
  final Map<String, dynamic> data;

  const UpdateAddressSubmitted(this.addressId, this.data);

  @override
  List<Object> get props => [];
}

class DeleteAddressSubmitted extends UpdateAddAddressEvent {
  final int addressId;
  const DeleteAddressSubmitted(this.addressId);
  @override
  List<Object> get props => [];
}
