// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: json['id'] as int,
      code: json['code'] as String,
      balance: (json['balance'] as num).toDouble(),
      depositBalance: (json['dep_balance'] as num).toDouble(),
      addresses: CustomerModel._addressesFromJson(json['addresses'] as List?),
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'balance': instance.balance,
      'dep_balance': instance.depositBalance,
      'addresses': CustomerModel._addressesToJson(instance.addresses),
    };
