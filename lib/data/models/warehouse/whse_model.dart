import 'package:json_annotation/json_annotation.dart';

part 'whse_model.g.dart';

@JsonSerializable()
class WarehouseModel {
  int id;
  String whsecode;
  String whsename;
  String branch;
  @JsonKey(name: "allowed_discount")
  double? allowedDiscount;

  WarehouseModel({
    required this.id,
    required this.whsecode,
    required this.whsename,
    required this.branch,
    this.allowedDiscount,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseModelToJson(this);
}
