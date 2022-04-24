part of 'update_customer_info_bloc.dart';

abstract class UpdateCustomerInfoEvent extends Equatable {
  const UpdateCustomerInfoEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends UpdateCustomerInfoEvent {
  final TextEditingController firstName;
  const FirstNameChanged(this.firstName);
  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends UpdateCustomerInfoEvent {
  final TextEditingController lastName;
  const LastNameChanged(this.lastName);
  @override
  List<Object> get props => [lastName];
}

class CustomerCodeChanged extends UpdateCustomerInfoEvent {
  final TextEditingController custCode;
  const CustomerCodeChanged(this.custCode);
  @override
  List<Object> get props => [custCode];
}

class CustsTypeChanged extends UpdateCustomerInfoEvent {
  final CustomerTypeModel custTypeModel;
  const CustsTypeChanged(this.custTypeModel);
  @override
  List<Object> get props => [custTypeModel];
}

class ContactNumberChanged extends UpdateCustomerInfoEvent {
  final TextEditingController contactNumber;
  const ContactNumberChanged(this.contactNumber);
  @override
  List<Object> get props => [contactNumber];
}

class EmailChanged extends UpdateCustomerInfoEvent {
  final TextEditingController email;
  const EmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

class CustomerSalesDiscountChanged extends UpdateCustomerInfoEvent {
  final TextEditingController salesDiscount;
  const CustomerSalesDiscountChanged(this.salesDiscount);
  @override
  List<Object> get props => [salesDiscount];
}

class CustomerPickupDiscountChanged extends UpdateCustomerInfoEvent {
  final TextEditingController pickupDiscount;
  const CustomerPickupDiscountChanged(this.pickupDiscount);
  @override
  List<Object> get props => [pickupDiscount];
}

class UsernameChanged extends UpdateCustomerInfoEvent {
  final TextEditingController username;
  const UsernameChanged(this.username);
  @override
  List<Object> get props => [username];
}

class PasswordChanged extends UpdateCustomerInfoEvent {
  final TextEditingController password;
  const PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends UpdateCustomerInfoEvent {
  final TextEditingController confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);
  @override
  List<Object> get props => [confirmPassword];
}

// class AddedCustomerAddress extends UpdateCustomerInfoEvent {
//   final CustomerAddressModel address;
//   const AddedCustomerAddress(this.address);
//   @override
//   List<Object> get props => [address];
// }

class CustomerActiveChanged extends UpdateCustomerInfoEvent {
  final bool isActive;
  const CustomerActiveChanged(this.isActive);
  @override
  List<Object> get props => [isActive];
}

class RemoveAddressByIndex extends UpdateCustomerInfoEvent {
  final int index;
  const RemoveAddressByIndex(this.index);

  @override
  List<Object> get props => [index];
}

class UpdateCustomerSubmitted extends UpdateCustomerInfoEvent {
  final int customerId;
  const UpdateCustomerSubmitted(this.customerId);

  @override
  List<Object> get props => [customerId];
}
