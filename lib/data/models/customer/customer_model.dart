import 'package:json_annotation/json_annotation.dart';

import 'customer_address_model.dart';
import 'customer_base_model.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends CustomerBaseModel {
  static List<CustomerAddressModel>? _addressesFromJson(List<dynamic>? data) {
    if (data != null) {
      return data.map((e) => CustomerAddressModel.fromJson(e)).toList();
    }
    return null;
  }

  static List<Map<String, dynamic>>? _addressesToJson(
      List<CustomerAddressModel>? addresses) {
    if (addresses != null) {
      return addresses.map((e) => e.toJson()).toList();
    }
    return null;
  }

  @JsonKey(fromJson: _addressesFromJson, toJson: _addressesToJson)
  List<CustomerAddressModel>? addresses;

  CustomerModel({
    required int id,
    required String code,
    required double balance,
    required double depositBalance,
    this.addresses,
  }) : super(
          id: id,
          code: code,
          balance: balance,
          depositBalance: depositBalance,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
