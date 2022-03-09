import 'package:json_annotation/json_annotation.dart';

part 'customer_base_model.g.dart';

@JsonSerializable()
class CustomerBaseModel {
  final int id;
  final String code;
  final String? name;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  final double balance;

  @JsonKey(name: "dep_balance")
  final double depositBalance;

  final String? email;

  @JsonKey(name: "contact_number")
  final String? contactNumber;

  @JsonKey(name: "customer_user")
  final int? customerUser;

  CustomerBaseModel({
    required this.id,
    required this.code,
    this.name,
    this.firstName,
    this.lastName,
    required this.balance,
    required this.depositBalance,
    this.email,
    this.contactNumber,
    this.customerUser,
  });

  factory CustomerBaseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerBaseModelToJson(this);
}
