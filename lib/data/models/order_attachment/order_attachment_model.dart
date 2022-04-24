import 'package:json_annotation/json_annotation.dart';

part 'order_attachment_model.g.dart';

@JsonSerializable()
class OrderAttachmentModel {
  final int id;
  @JsonKey(name: 'image_url')
  final String imageUrl;

  const OrderAttachmentModel({
    required this.id,
    required this.imageUrl,
  });

  factory OrderAttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$OrderAttachmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderAttachmentModelToJson(this);
}
