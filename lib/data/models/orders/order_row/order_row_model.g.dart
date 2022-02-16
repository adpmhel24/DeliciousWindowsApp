// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRowModel _$OrderRowModelFromJson(Map<String, dynamic> json) =>
    OrderRowModel(
      id: json['id'] as int?,
      docId: json['doc_id'] as int?,
      itemCode: json['item_code'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      qtyDelivered: (json['qty_delivered'] as num?)?.toDouble(),
      uom: json['uom'] as String?,
      unitPrice: (json['unit_price'] as num?)?.toDouble(),
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

Map<String, dynamic> _$OrderRowModelToJson(OrderRowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doc_id': instance.docId,
      'item_code': instance.itemCode,
      'quantity': instance.quantity,
      'qty_delivered': instance.qtyDelivered,
      'uom': instance.uom,
      'unit_price': instance.unitPrice,
      'disc_amount': instance.discAmount,
      'discprcnt': instance.discprcnt,
      'gross': instance.gross,
      'subtotal': instance.subtotal,
      'linestatus': instance.linestatus,
      'comments': instance.comments,
      'updated_by': instance.updatedBy,
      'date_updated': instance.dateUpdated?.toIso8601String(),
    };
