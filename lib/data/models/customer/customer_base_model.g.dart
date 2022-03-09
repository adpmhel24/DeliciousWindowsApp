// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBaseModel _$CustomerBaseModelFromJson(Map<String, dynamic> json) =>
    CustomerBaseModel(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      balance: (json['balance'] as num).toDouble(),
      depositBalance: (json['dep_balance'] as num).toDouble(),
      email: json['email'] as String?,
      contactNumber: json['contact_number'] as String?,
      customerUser: json['customer_user'] as int?,
    );

Map<String, dynamic> _$CustomerBaseModelToJson(CustomerBaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'balance': instance.balance,
      'dep_balance': instance.depositBalance,
      'email': instance.email,
      'contact_number': instance.contactNumber,
      'customer_user': instance.customerUser,
    };
