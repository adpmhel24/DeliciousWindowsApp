// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int,
      comment: json['comment'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      createdBy: json['created_by'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'date_created': instance.dateCreated.toIso8601String(),
      'created_by': instance.createdBy,
    };
