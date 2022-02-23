// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_header_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHeaderModel _$OrderHeaderModelFromJson(Map<String, dynamic> json) =>
    OrderHeaderModel(
      id: json['id'] as int?,
      transdate: json['transdate'] == null
          ? null
          : DateTime.parse(json['transdate'] as String),
      deliveryDate: json['delivery_date'] == null
          ? null
          : DateTime.parse(json['delivery_date'] as String),
      custCode: json['cust_code'] as String?,
      details: json['details'] as String?,
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      delfee: (json['delfee'] as num?)?.toDouble(),
      otherfee: (json['otherfee'] as num?)?.toDouble(),
      doctotal: (json['doctotal'] as num?)?.toDouble(),
      balance: (json['balance'] as num?)?.toDouble() ?? 0.00,
      gross: (json['gross'] as num?)?.toDouble(),
      deliveryMethod: json['delivery_method'] as String?,
      paymentMethod: json['payment_method'] as String?,
      orderStatus: json['order_status'] as String?,
      paymentStatus: json['payment_status'] as String?,
      remarks: json['remarks'] as String?,
      address: json['address'] as String?,
      dispatchingWhse: json['dispatching_whse'] as String?,
      salesReference: json['sales_reference'] as String?,
      user: json['user'] as String?,
    )
      ..paidAmount = (json['paid_amount'] as num?)?.toDouble()
      ..salestype = json['salestype'] as String?
      ..disctype = json['disctype'] as String?
      ..paymentReference = json['payment_reference'] as String?;

Map<String, dynamic> _$OrderHeaderModelToJson(OrderHeaderModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', OrderHeaderModel.toNull(instance.id));
  writeNotNull('transdate', OrderHeaderModel.toNull(instance.transdate));
  writeNotNull('delivery_date', OrderHeaderModel.toNull(instance.deliveryDate));
  writeNotNull('cust_code', OrderHeaderModel.toNull(instance.custCode));
  writeNotNull('details', OrderHeaderModel.toNull(instance.details));
  writeNotNull('subtotal', OrderHeaderModel.toNull(instance.subtotal));
  writeNotNull('delfee', OrderHeaderModel.toNull(instance.delfee));
  writeNotNull('otherfee', OrderHeaderModel.toNull(instance.otherfee));
  writeNotNull('doctotal', OrderHeaderModel.toNull(instance.doctotal));
  val['paid_amount'] = instance.paidAmount;
  writeNotNull('balance', OrderHeaderModel.toNull(instance.balance));
  writeNotNull('gross', OrderHeaderModel.toNull(instance.gross));
  writeNotNull(
      'delivery_method', OrderHeaderModel.toNull(instance.deliveryMethod));
  val['payment_method'] = instance.paymentMethod;
  val['order_status'] = instance.orderStatus;
  writeNotNull(
      'payment_status', OrderHeaderModel.toNull(instance.paymentStatus));
  val['remarks'] = instance.remarks;
  writeNotNull('address', OrderHeaderModel.toNull(instance.address));
  val['dispatching_whse'] = instance.dispatchingWhse;
  val['salestype'] = instance.salestype;
  val['disctype'] = instance.disctype;
  val['payment_reference'] = instance.paymentReference;
  writeNotNull(
      'sales_reference', OrderHeaderModel.toNull(instance.salesReference));
  writeNotNull('user', OrderHeaderModel.toNull(instance.user));
  return val;
}
