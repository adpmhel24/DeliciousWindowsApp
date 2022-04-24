part of 'update_customer_info_bloc.dart';

class UpdateCustomerInfoState extends Equatable {
  const UpdateCustomerInfoState({
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
    this.isActive = const BoolField.pure(),
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
  final BoolField isActive;
  final String message;

  UpdateCustomerInfoState copyWith({
    FormzStatus? status,
    StringField? firstName,
    StringField? lastName,
    IntField? custType,
    StringField? custCode,
    StringField? contactNumber,
    DoubleField? salesDiscount,
    DoubleField? pickupDiscount,
    EmailField? emailAddress,
    BoolField? isActive,
    StringField? username,
    StringField? password,
    String? message,
  }) =>
      UpdateCustomerInfoState(
        status: status ?? this.status,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        custType: custType ?? this.custType,
        custCode: custCode ?? this.custCode,
        contactNumber: contactNumber ?? this.contactNumber,
        emailAddress: emailAddress ?? this.emailAddress,
        salesDiscount: salesDiscount ?? this.salesDiscount,
        pickupDiscount: pickupDiscount ?? this.pickupDiscount,
        isActive: isActive ?? this.isActive,
        username: username ?? this.username,
        password: password ?? this.password,
        message: message ?? this.message,
      );

  Map<String, dynamic> toMap() {
    return {
      "header": {
        "first_name": firstName,
        "last_name": lastName,
        "cust_type": custType,
        "code": custCode,
        "email": emailAddress,
        "contact_number": contactNumber,
        "allowed_disc": salesDiscount,
        "pickup_disc": pickupDiscount,
        "is_active": isActive,
      },
      "user": {
        "username": username,
        "password": password,
      }
    };
  }

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
        isActive,
        pickupDiscount,
        username,
        password,
        message,
      ];
}
