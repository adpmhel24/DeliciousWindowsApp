import 'package:json_annotation/json_annotation.dart';

part 'order_row_model.g.dart';

@JsonSerializable()
class OrderRowModel {
  int? id;

  @JsonKey(name: "doc_id")
  int? docId;

  @JsonKey(name: "item_code")
  String? itemCode;
  double? quantity;

  @JsonKey(name: "qty_delivered")
  double? qtyDelivered;
  String? uom;

  @JsonKey(name: "unit_price")
  double? unitPrice;

  @JsonKey(name: "disc_amount")
  double? discAmount;

  double? discprcnt;
  double? gross;
  double? subtotal;
  double? linestatus;
  String? comments;

  @JsonKey(name: "updated_by")
  int? updatedBy;

  @JsonKey(name: "date_updated")
  DateTime? dateUpdated;

  OrderRowModel(
      {this.id,
      this.docId,
      this.itemCode,
      this.quantity,
      this.qtyDelivered,
      this.uom,
      this.unitPrice,
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
