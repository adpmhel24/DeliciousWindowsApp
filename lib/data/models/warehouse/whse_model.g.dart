// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseModel _$WarehouseModelFromJson(Map<String, dynamic> json) =>
    WarehouseModel(
      id: json['id'] as int,
      whsecode: json['whsecode'] as String,
      whsename: json['whsename'] as String,
      branch: json['branch'] as String,
      allowedDiscount: (json['allowed_discount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WarehouseModelToJson(WarehouseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'whsecode': instance.whsecode,
      'whsename': instance.whsename,
      'branch': instance.branch,
      'allowed_discount': instance.allowedDiscount,
    };
