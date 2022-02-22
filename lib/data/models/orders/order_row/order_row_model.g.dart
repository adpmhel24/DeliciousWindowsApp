// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRowModel _$OrderRowModelFromJson(Map<String, dynamic> json) =>
    OrderRowModel(
      id: json['id'] as int,
      docId: json['doc_id'] as int?,
      itemCode: json['item_code'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      qtyDelivered: (json['qty_delivered'] as num?)?.toDouble(),
      uom: json['uom'] as String?,
      discAmount: (json['disc_amount'] as num?)?.toDouble(),
      discprcnt: (json['discprcnt'] as num?)?.toDouble(),
      gross: (json['gross'] as num?)?.toDouble(),
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      linestatus: (json['linestatus'] as num?)?.toDouble(),
      comments: json['comments'] as String?,
      updatedBy: json['updated_by'] as int?,
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
    );

Map<String, dynamic> _$OrderRowModelToJson(OrderRowModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('doc_id', OrderRowModel.toNull(instance.docId));
  writeNotNull('item_code', OrderRowModel.toNull(instance.itemCode));
  writeNotNull('quantity', OrderRowModel.toNull(instance.quantity));
  writeNotNull('qty_delivered', OrderRowModel.toNull(instance.qtyDelivered));
  writeNotNull('uom', OrderRowModel.toNull(instance.uom));
  writeNotNull('unit_price', OrderRowModel.toNull(instance.unitPrice));
  val['disc_amount'] = instance.discAmount;
  val['discprcnt'] = instance.discprcnt;
  writeNotNull('gross', OrderRowModel.toNull(instance.gross));
  writeNotNull('subtotal', OrderRowModel.toNull(instance.subtotal));
  writeNotNull('linestatus', OrderRowModel.toNull(instance.linestatus));
  val['comments'] = instance.comments;
  writeNotNull('updated_by', OrderRowModel.toNull(instance.updatedBy));
  writeNotNull('date_updated', OrderRowModel.toNull(instance.dateUpdated));
  return val;
}
