part of 'create_customer_bloc.dart';

class CreateCustomerState extends Equatable {
  const CreateCustomerState({
    this.status = FormzStatus.pure,
    this.firstName = const StringField.pure(),
    this.lastName = const StringField.pure(),
    this.custType = const IntField.pure(),
    this.custCode = const StringField.pure(),
    this.contactNumber = const StringField.pure(),
    this.emailAddress = const EmailField.pure(),
    this.salesDiscount = const DoubleField.pure(),
    this.pickupDiscount = const DoubleField.pure(),
    this.username = const StringField.pure(),
    this.password = const StringField.pure(),
    this.confirmPassword = const ConfirmPasswordField.pure(),
    this.addresses = const [],
    this.message = "",
  });

  final FormzStatus status;
  final StringField firstName;
  final StringField lastName;
  final IntField custType;
  final StringField custCode;
  final StringField contactNumber;
  final EmailField emailAddress;
  final DoubleField salesDiscount;
  final DoubleField pickupDiscount;
  final StringField username;
  final StringField password;
  final ConfirmPasswordField confirmPassword;
  final List<CustomerAddressModel> addresses;
  final String message;

  CreateCustomerState copyWith({
    FormzStatus? status,
    StringField? firstName,
    StringField? lastName,
    IntField? custType,
    StringField? custCode,
    StringField? contactNumber,
    EmailField? emailAddress,
    DoubleField? salesDiscount,
    DoubleField? pickupDiscount,
    StringField? username,
    StringField? password,
    ConfirmPasswordField? confirmPassword,
    List<CustomerAddressModel>? addresses,
    String? message,
  }) =>
      CreateCustomerState(
        status: status ?? this.status,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        custType: custType ?? this.custType,
        custCode: custCode ?? this.custCode,
        contactNumber: contactNumber ?? this.contactNumber,
        emailAddress: emailAddress ?? this.emailAddress,
        salesDiscount: salesDiscount ?? this.salesDiscount,
        pickupDiscount: pickupDiscount ?? this.pickupDiscount,
        username: username ?? this.username,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        addresses: addresses ?? this.addresses,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [
        status,
        firstName,
        lastName,
        custType,
        custCode,
        contactNumber,
        emailAddress,
        salesDiscount,
        pickupDiscount,
        username,
        password,
        confirmPassword,
        addresses,
        message,
      ];
}
