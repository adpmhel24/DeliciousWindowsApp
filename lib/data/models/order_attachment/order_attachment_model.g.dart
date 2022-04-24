// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAttachmentModel _$OrderAttachmentModelFromJson(
        Map<String, dynamic> json) =>
    OrderAttachmentModel(
      id: json['id'] as int,
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$OrderAttachmentModelToJson(
        OrderAttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
    };
