import 'package:json_annotation/json_annotation.dart';

part 'order_row_model.g.dart';

@JsonSerializable()
class OrderRowModel {
  static toNull(_) => null;

  int id;

  @JsonKey(name: "doc_id", toJson: toNull, includeIfNull: false)
  int? docId;

  @JsonKey(name: "item_code", toJson: toNull, includeIfNull: false)
  String? itemCode;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double quantity;

  @JsonKey(name: "qty_delivered", toJson: toNull, includeIfNull: false)
  double? qtyDelivered;

  @JsonKey(toJson: toNull, includeIfNull: false)
  String? uom;

  @JsonKey(name: "unit_price", toJson: toNull, includeIfNull: false)
  double unitPrice;

  @JsonKey(name: "disc_amount")
  double? discAmount;

  double? discprcnt;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double? gross;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double? subtotal;
  @JsonKey(toJson: toNull, includeIfNull: false)
  double? linestatus;

  String? comments;

  @JsonKey(name: "updated_by", toJson: toNull, includeIfNull: false)
  int? updatedBy;

  @JsonKey(name: "date_updated", toJson: toNull, includeIfNull: false)
  DateTime? dateUpdated;

  OrderRowModel(
      {required this.id,
      this.docId,
      this.itemCode,
      required this.quantity,
      required this.unitPrice,
      this.qtyDelivered,
      this.uom,
      this.discAmount,
      this.discprcnt,
      this.gross,
      this.subtotal,
      this.linestatus,
      this.comments,
      this.updatedBy,
      this.dateUpdated});

  factory OrderRowModel.fromJson(Map<String, dynamic> json) =>
      _$OrderRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRowModelToJson(this);
}

class OrderRowTableHeader {
  static const id = 'Id';
  static const itemCode = 'Item Code';
  static const quantity = 'Quantity';
  static const uom = 'UoM';
  static const unitPrice = 'Unit Price';
  static const discAmount = 'Discount Amount';
  static const discprcnt = 'Discount %';
  static const gross = 'Gross';
  static const subtotal = 'Subtotal';
  static const comments = 'Comments';
  static const updatedBy = 'Updated By';
  static const dateUpdated = 'Date Updated';
}
