// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      rows: OrderModel._orderRowFromJson(json['rows'] as List),
    )
      ..id = json['id'] as int?
      ..transdate = json['transdate'] == null
          ? null
          : DateTime.parse(json['transdate'] as String)
      ..deliveryDate = json['delivery_date'] == null
          ? null
          : DateTime.parse(json['delivery_date'] as String)
      ..custCode = json['cust_code'] as String?
      ..details = json['details'] as String?
      ..subtotal = (json['subtotal'] as num?)?.toDouble()
      ..delfee = (json['delfee'] as num?)?.toDouble()
      ..otherfee = (json['otherfee'] as num?)?.toDouble()
      ..doctotal = (json['doctotal'] as num?)?.toDouble()
      ..balance = (json['balance'] as num?)?.toDouble()
      ..gross = (json['gross'] as num?)?.toDouble()
      ..deliveryMethod = json['delivery_method'] as String?
      ..paymentMethod = json['payment_method'] as String?
      ..orderStatus = json['order_status'] as String?
      ..paymentStatus = json['payment_status'] as String?
      ..remarks = json['remarks'] as String?
      ..address = json['address'] as String?
      ..dispatchingWhse = json['dispatching_whse'] as String?
      ..salesReference = json['sales_reference'] as String?
      ..user = json['user'] as String?;

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transdate': instance.transdate?.toIso8601String(),
      'delivery_date': instance.deliveryDate?.toIso8601String(),
      'cust_code': instance.custCode,
      'details': instance.details,
      'subtotal': instance.subtotal,
      'delfee': instance.delfee,
      'otherfee': instance.otherfee,
      'doctotal': instance.doctotal,
      'balance': instance.balance,
      'gross': instance.gross,
      'delivery_method': instance.deliveryMethod,
      'payment_method': instance.paymentMethod,
      'order_status': instance.orderStatus,
      'payment_status': instance.paymentStatus,
      'remarks': instance.remarks,
      'address': instance.address,
      'dispatching_whse': instance.dispatchingWhse,
      'sales_reference': instance.salesReference,
      'user': instance.user,
      'rows': instance.rows,
    };
