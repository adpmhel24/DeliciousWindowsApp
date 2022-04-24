part of 'create_customer_bloc.dart';

abstract class CreateCustomerEvent extends Equatable {
  const CreateCustomerEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends CreateCustomerEvent {
  final TextEditingController firstName;
  const FirstNameChanged(this.firstName);
  @override
  List<Object> get props => [firstName];
}

class LastNameChanged extends CreateCustomerEvent {
  final TextEditingController lastName;
  const LastNameChanged(this.lastName);
  @override
  List<Object> get props => [lastName];
}

class CustomerCodeChanged extends CreateCustomerEvent {
  final TextEditingController custCode;
  const CustomerCodeChanged(this.custCode);
  @override
  List<Object> get props => [custCode];
}

class CustsTypeChanged extends CreateCustomerEvent {
  final CustomerTypeModel custTypeModel;
  const CustsTypeChanged(this.custTypeModel);
  @override
  List<Object> get props => [custTypeModel];
}

class ContactNumberChanged extends CreateCustomerEvent {
  final TextEditingController contactNumber;
  const ContactNumberChanged(this.contactNumber);
  @override
  List<Object> get props => [contactNumber];
}

class EmailChanged extends CreateCustomerEvent {
  final TextEditingController email;
  const EmailChanged(this.email);
  @override
  List<Object> get props => [email];
}

class CustomerSalesDiscountChanged extends CreateCustomerEvent {
  final TextEditingController salesDiscount;
  const CustomerSalesDiscountChanged(this.salesDiscount);
  @override
  List<Object> get props => [salesDiscount];
}

class CustomerPickupDiscountChanged extends CreateCustomerEvent {
  final TextEditingController pickupDiscount;
  const CustomerPickupDiscountChanged(this.pickupDiscount);
  @override
  List<Object> get props => [pickupDiscount];
}

class UsernameChanged extends CreateCustomerEvent {
  final TextEditingController username;
  const UsernameChanged(this.username);
  @override
  List<Object> get props => [username];
}

class PasswordChanged extends CreateCustomerEvent {
  final TextEditingController password;
  const PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends CreateCustomerEvent {
  final TextEditingController confirmPassword;
  const ConfirmPasswordChanged(this.confirmPassword);
  @override
  List<Object> get props => [confirmPassword];
}

class AddedCustomerAddress extends CreateCustomerEvent {
  final CustomerAddressModel address;
  const AddedCustomerAddress(this.address);
  @override
  List<Object> get props => [address];
}

class RemoveAddressByIndex extends CreateCustomerEvent {
  final int index;
  const RemoveAddressByIndex(this.index);

  @override
  List<Object> get props => [index];
}

class NewCustomerSubmitted extends CreateCustomerEvent {}
