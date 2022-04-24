import 'package:json_annotation/json_annotation.dart';

part 'customer_base_model.g.dart';

@JsonSerializable()
class CustomerBaseModel {
  int? id;

  int? lineCount;

  String? code;
  String? name;

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  double? balance;

  @JsonKey(name: "dep_balance")
  double? depositBalance;

  String? email;

  @JsonKey(name: "contact_number")
  String? contactNumber;

  @JsonKey(name: "cust_type")
  int? custType;

  String? custTypeName;

  @JsonKey(name: "customer_user")
  int? customerUser;

  @JsonKey(name: "allowed_disc")
  double? allowedDisc;

  @JsonKey(name: "pickup_disc")
  double? pickupDisc;

  @JsonKey(name: "is_active")
  bool isActive;

  Map<String, dynamic>? user;

  CustomerBaseModel({
    this.id,
    this.lineCount,
    this.code,
    this.name,
    this.firstName,
    this.lastName,
    this.balance,
    this.depositBalance,
    this.custType,
    this.email,
    this.contactNumber,
    this.customerUser,
    this.custTypeName,
    this.allowedDisc = 0.00,
    this.pickupDisc = 0.00,
    this.user,
    this.isActive = true,
  });

  factory CustomerBaseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerBaseModelToJson(this);
}
