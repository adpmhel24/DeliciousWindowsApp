import 'package:json_annotation/json_annotation.dart';

part 'order_header_model.g.dart';

@JsonSerializable()
class OrderHeaderModel {
  int? id;
  DateTime? transdate;

  @JsonKey(name: 'delivery_date')
  DateTime? deliveryDate;

  @JsonKey(name: 'cust_code')
  String? custCode;

  String? details;

  double? subtotal;

  double? delfee;
  double? otherfee;
  double? doctotal;
  double? balance;

  double? gross;

  @JsonKey(name: 'delivery_method')
  String? deliveryMethod;

  @JsonKey(name: 'payment_method')
  String? paymentMethod;

  @JsonKey(name: 'order_status')
  String? orderStatus;

  @JsonKey(name: 'payment_status')
  String? paymentStatus;

  String? remarks;
  String? address;

  @JsonKey(name: 'dispatching_whse')
  String? dispatchingWhse;

  @JsonKey(name: 'sales_reference')
  String? salesReference;
  String? user;

  OrderHeaderModel(
      {this.id,
      this.transdate,
      this.deliveryDate,
      this.custCode,
      this.details,
      this.subtotal,
      this.delfee,
      this.otherfee,
      this.doctotal,
      this.balance,
      this.gross,
      this.deliveryMethod,
      this.paymentMethod,
      this.orderStatus,
      this.paymentStatus,
      this.remarks,
      this.address,
      this.dispatchingWhse,
      this.salesReference,
      this.user});

  factory OrderHeaderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderHeaderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHeaderModelToJson(this);
}

class OrderTableHeader {
  static const id = 'Order Id';
  static const transdate = 'Transaction Date';
  static const deliveryDate = 'Delivery Date';
  static const custCode = 'Customer Code';
  static const details = 'Details';
  static const subtotal = 'Subtotal';
  static const delfee = 'Delivery Fee';
  static const otherfee = 'Other Fee';
  static const doctotal = 'Doctotal';
  static const balance = 'Balance';
  static const gross = 'Gross';
  static const deliveryMethod = 'Delivery Method';
  static const paymentMethod = 'Payment Method';
  static const orderStatus = 'Order Status';
  static const paymentStatus = 'Payment Status';
  static const remarks = 'Remarks';
  static const address = 'Address';
  static const dispatchingWhse = 'Dispatching Warehouse';
  static const salesReference = 'Sales Reference';
  static const user = 'User';
}
