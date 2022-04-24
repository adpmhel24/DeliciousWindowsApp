// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerBaseModel _$CustomerBaseModelFromJson(Map<String, dynamic> json) =>
    CustomerBaseModel(
      id: json['id'] as int?,
      lineCount: json['lineCount'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      depositBalance: (json['dep_balance'] as num?)?.toDouble(),
      custType: json['cust_type'] as int?,
      email: json['email'] as String?,
      contactNumber: json['contact_number'] as String?,
      customerUser: json['customer_user'] as int?,
      custTypeName: json['custTypeName'] as String?,
      allowedDisc: (json['allowed_disc'] as num?)?.toDouble() ?? 0.00,
      pickupDisc: (json['pickup_disc'] as num?)?.toDouble() ?? 0.00,
      user: json['user'] as Map<String, dynamic>?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$CustomerBaseModelToJson(CustomerBaseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lineCount': instance.lineCount,
      'code': instance.code,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'balance': instance.balance,
      'dep_balance': instance.depositBalance,
      'email': instance.email,
      'contact_number': instance.contactNumber,
      'cust_type': instance.custType,
      'custTypeName': instance.custTypeName,
      'customer_user': instance.customerUser,
      'allowed_disc': instance.allowedDisc,
      'pickup_disc': instance.pickupDisc,
      'is_active': instance.isActive,
      'user': instance.user,
    };
