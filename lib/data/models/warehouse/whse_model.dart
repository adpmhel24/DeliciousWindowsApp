import 'package:json_annotation/json_annotation.dart';

part 'whse_model.g.dart';

@JsonSerializable()
class WhseModel {
  int id;
  String whsecode;
  String whsename;
  String branch;
  @JsonKey(name: "allowed_discount")
  double? allowedDiscount;

  WhseModel({
    required this.id,
    required this.whsecode,
    required this.whsename,
    required this.branch,
    this.allowedDiscount,
  });

  factory WhseModel.fromJson(Map<String, dynamic> json) =>
      _$WhseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WhseModelToJson(this);
}
