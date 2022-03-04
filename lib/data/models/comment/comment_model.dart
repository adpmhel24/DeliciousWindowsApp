import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  final int id;

  final String comment;

  @JsonKey(name: "date_created")
  final DateTime dateCreated;

  @JsonKey(name: "created_by")
  final String createdBy;

  CommentModel({
    required this.id,
    required this.comment,
    required this.dateCreated,
    required this.createdBy,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
