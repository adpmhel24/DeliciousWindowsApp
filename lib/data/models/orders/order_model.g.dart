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
      ..customerType = json['customer_type'] as String?
      ..contactNumber = json['contact_number'] as String?
      ..details = json['details'] as String?
      ..subtotal = (json['subtotal'] as num?)?.toDouble()
      ..delfee = (json['delfee'] as num?)?.toDouble()
      ..otherfee = (json['otherfee'] as num?)?.toDouble()
      ..doctotal = (json['doctotal'] as num?)?.toDouble()
      ..paidAmount = (json['paid_amount'] as num?)?.toDouble()
      ..balance = (json['balance'] as num?)?.toDouble()
      ..gross = (json['gross'] as num?)?.toDouble()
      ..deliveryMethod = json['delivery_method'] as String?
      ..paymentMethod = json['payment_method'] as String?
      ..orderStatus = json['order_status'] as String?
      ..paymentStatus = json['payment_status'] as String?
      ..remarks = json['remarks'] as String?
      ..address = json['address'] as String?
      ..dispatchingWhse = json['dispatching_whse'] as String?
      ..salestype = json['salestype'] as String?
      ..disctype = json['disctype'] as String?
      ..paymentReference = json['payment_reference'] as String?
      ..salesReference = json['sales_reference'] as String?
      ..attachmentCount = json['attachment_count'] as int?
      ..user = json['user'] as String?
      ..confirmedBy = json['confirmed_by'] as String?
      ..dispatchedBy = json['dispatched_by'] as String?
      ..canceledBy = json['canceled_by'] as String?
      ..dateConfirmed = json['date_confirmed'] == null
          ? null
          : DateTime.parse(json['date_confirmed'] as String)
      ..dateDispatched = json['date_dispatched'] == null
          ? null
          : DateTime.parse(json['date_dispatched'] as String)
      ..dateCanceled = json['date_canceled'] == null
          ? null
          : DateTime.parse(json['date_canceled'] as String);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) {
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
  writeNotNull('customer_type', OrderHeaderModel.toNull(instance.customerType));
  writeNotNull(
      'contact_number', OrderHeaderModel.toNull(instance.contactNumber));
  writeNotNull('details', OrderHeaderModel.toNull(instance.details));
  writeNotNull('subtotal', OrderHeaderModel.toNull(instance.subtotal));
  val['delfee'] = instance.delfee;
  val['otherfee'] = instance.otherfee;
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
  writeNotNull(
      'attachment_count', OrderHeaderModel.toNull(instance.attachmentCount));
  writeNotNull('user', OrderHeaderModel.toNull(instance.user));
  writeNotNull('confirmed_by', OrderHeaderModel.toNull(instance.confirmedBy));
  writeNotNull('dispatched_by', OrderHeaderModel.toNull(instance.dispatchedBy));
  writeNotNull('canceled_by', OrderHeaderModel.toNull(instance.canceledBy));
  writeNotNull(
      'date_confirmed', OrderHeaderModel.toNull(instance.dateConfirmed));
  writeNotNull(
      'date_dispatched', OrderHeaderModel.toNull(instance.dateDispatched));
  writeNotNull('date_canceled', OrderHeaderModel.toNull(instance.dateCanceled));
  val['rows'] = OrderModel._orderRowToJson(instance.rows);
  return val;
}
