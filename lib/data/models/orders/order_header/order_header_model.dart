import 'package:fluent_ui/fluent_ui.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

part 'order_header_model.g.dart';

@JsonSerializable()
class OrderHeaderModel {
  static toNull(_) => null;

  @JsonKey(toJson: toNull, includeIfNull: false)
  int? id;

  @JsonKey(toJson: toNull, includeIfNull: false)
  DateTime? transdate;

  @JsonKey(name: 'delivery_date', toJson: toNull, includeIfNull: false)
  DateTime? deliveryDate;

  @JsonKey(name: 'cust_code', toJson: toNull, includeIfNull: false)
  String? custCode;

  @JsonKey(name: 'customer_type', toJson: toNull, includeIfNull: false)
  String? customerType;

  @JsonKey(name: 'contact_number', toJson: toNull, includeIfNull: false)
  String? contactNumber;

  @JsonKey(toJson: toNull, includeIfNull: false)
  String? details;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double? subtotal;

  double? delfee;

  double? otherfee;
  @JsonKey(toJson: toNull, includeIfNull: false)
  double? doctotal;

  @JsonKey(name: 'paid_amount')
  double? paidAmount;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double? balance;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double? gross;

  @JsonKey(name: 'delivery_method', toJson: toNull, includeIfNull: false)
  String? deliveryMethod;

  @JsonKey(name: 'payment_method')
  String? paymentMethod;

  @JsonKey(name: 'order_status')
  String? orderStatus;

  @JsonKey(name: 'payment_status', toJson: toNull, includeIfNull: false)
  String? paymentStatus;

  String? remarks;

  @JsonKey(toJson: toNull, includeIfNull: false)
  String? address;

  @JsonKey(name: 'dispatching_whse')
  String? dispatchingWhse;

  String? salestype;
  String? disctype;

  @JsonKey(name: 'payment_reference')
  String? paymentReference;

  @JsonKey(name: 'sales_reference', toJson: toNull, includeIfNull: false)
  String? salesReference;

  @JsonKey(name: 'attachment_count', toJson: toNull, includeIfNull: false)
  int? attachmentCount;

  @JsonKey(toJson: toNull, includeIfNull: false)
  String? user;

  @JsonKey(name: 'confirmed_by', toJson: toNull, includeIfNull: false)
  String? confirmedBy;

  @JsonKey(name: 'dispatched_by', toJson: toNull, includeIfNull: false)
  String? dispatchedBy;

  @JsonKey(name: 'canceled_by', toJson: toNull, includeIfNull: false)
  String? canceledBy;

  @JsonKey(name: 'date_confirmed', toJson: toNull, includeIfNull: false)
  DateTime? dateConfirmed;

  @JsonKey(name: 'date_dispatched', toJson: toNull, includeIfNull: false)
  DateTime? dateDispatched;

  @JsonKey(name: 'date_canceled', toJson: toNull, includeIfNull: false)
  DateTime? dateCanceled;

  OrderHeaderModel({
    this.id,
    this.transdate,
    this.deliveryDate,
    this.custCode,
    this.customerType,
    this.details,
    this.subtotal,
    this.delfee,
    this.otherfee,
    this.doctotal,
    this.balance = 0.00,
    this.gross,
    this.deliveryMethod,
    this.paymentMethod,
    this.orderStatus,
    this.paymentStatus,
    this.remarks,
    this.address,
    this.dispatchingWhse,
    this.salesReference,
    this.user,
    this.confirmedBy,
    this.dispatchedBy,
    this.canceledBy,
    this.dateConfirmed,
    this.dateDispatched,
    this.dateCanceled,
    this.attachmentCount,
  });

  factory OrderHeaderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderHeaderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHeaderModelToJson(this);
}

class OrderTableHeader {
  static const id = 'Order Id';
  static const transdate = 'Transaction Date';
  static const deliveryDate = 'Delivery Date';
  static const custCode = 'Customer Code';
  static const customerType = 'Customer Type';
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
  static const confirmedBy = 'Confirmed By';
  static const dispatchedBy = 'Dispatched By';
  static const canceledBy = 'Canceled By';
  static const dateConfirmed = 'Date Confirmed';
  static const dateDispatched = 'Date Dispatched';
  static const dateCanceled = 'Date Canceled';
  static const comments = 'Comments';
  static const attachments = 'Attachments';

  static List<GridColumn> forConfirmationColumns(
      Map<String, dynamic> columnWidths) {
    return [
      GridColumn(
        width: columnWidths[OrderTableHeader.id]!,
        columnName: OrderTableHeader.id,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.id,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.transdate]!,
        columnName: OrderTableHeader.transdate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.transdate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryDate]!,
        columnName: OrderTableHeader.deliveryDate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryDate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.custCode]!,
        columnName: OrderTableHeader.custCode,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.custCode,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.customerType]!,
        columnName: OrderTableHeader.customerType,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.customerType,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.details]!,
        columnName: OrderTableHeader.details,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.details,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.subtotal]!,
        columnName: OrderTableHeader.subtotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.subtotal,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.delfee]!,
        columnName: OrderTableHeader.delfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.delfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.otherfee]!,
        columnName: OrderTableHeader.otherfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.otherfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.doctotal]!,
        columnName: OrderTableHeader.doctotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.doctotal,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryMethod]!,
        columnName: OrderTableHeader.deliveryMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.paymentMethod]!,
        columnName: OrderTableHeader.paymentMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.paymentMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.attachments]!,
        columnName: OrderTableHeader.attachments,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.attachments,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.remarks]!,
        columnName: OrderTableHeader.remarks,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.remarks,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.address]!,
        columnName: OrderTableHeader.address,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.user]!,
        columnName: OrderTableHeader.user,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.user,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }

  static List<GridColumn> forDispatchColumns(
      Map<String, dynamic> columnWidths) {
    return [
      GridColumn(
        width: columnWidths[OrderTableHeader.id]!,
        columnName: OrderTableHeader.id,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.id,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.transdate]!,
        columnName: OrderTableHeader.transdate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.transdate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryDate]!,
        columnName: OrderTableHeader.deliveryDate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryDate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.custCode]!,
        columnName: OrderTableHeader.custCode,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.custCode,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.customerType]!,
        columnName: OrderTableHeader.customerType,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.customerType,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.details]!,
        columnName: OrderTableHeader.details,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.details,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.balance]!,
        columnName: OrderTableHeader.balance,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.balance,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.paymentStatus]!,
        columnName: OrderTableHeader.paymentStatus,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.paymentStatus,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryMethod]!,
        columnName: OrderTableHeader.deliveryMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.paymentMethod]!,
        columnName: OrderTableHeader.paymentMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.paymentMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.attachments]!,
        columnName: OrderTableHeader.attachments,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.attachments,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.remarks]!,
        columnName: OrderTableHeader.remarks,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.remarks,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.address]!,
        columnName: OrderTableHeader.address,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.user]!,
        columnName: OrderTableHeader.user,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.user,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.confirmedBy]!,
        columnName: OrderTableHeader.confirmedBy,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.confirmedBy,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.dateConfirmed]!,
        columnName: OrderTableHeader.dateConfirmed,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.dateConfirmed,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }

  static List<GridColumn> completedColumns(Map<String, dynamic> columnWidths) {
    return [
      GridColumn(
        width: columnWidths[OrderTableHeader.id]!,
        columnName: OrderTableHeader.id,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.id,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.transdate]!,
        columnName: OrderTableHeader.transdate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.transdate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryDate]!,
        columnName: OrderTableHeader.deliveryDate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryDate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.salesReference]!,
        columnName: OrderTableHeader.salesReference,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.salesReference,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.custCode]!,
        columnName: OrderTableHeader.custCode,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.custCode,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.customerType]!,
        columnName: OrderTableHeader.customerType,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.customerType,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.details]!,
        columnName: OrderTableHeader.details,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.details,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.subtotal]!,
        columnName: OrderTableHeader.subtotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.subtotal,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.delfee]!,
        columnName: OrderTableHeader.delfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.delfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.otherfee]!,
        columnName: OrderTableHeader.otherfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.otherfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.doctotal]!,
        columnName: OrderTableHeader.doctotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.doctotal,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryMethod]!,
        columnName: OrderTableHeader.deliveryMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.paymentMethod]!,
        columnName: OrderTableHeader.paymentMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.paymentMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.attachments]!,
        columnName: OrderTableHeader.attachments,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.attachments,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.remarks]!,
        columnName: OrderTableHeader.remarks,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.remarks,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.address]!,
        columnName: OrderTableHeader.address,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.user]!,
        columnName: OrderTableHeader.user,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.user,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.dispatchedBy]!,
        columnName: OrderTableHeader.dispatchedBy,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.dispatchedBy,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.dateDispatched]!,
        columnName: OrderTableHeader.dateDispatched,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.dateDispatched,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }

  static List<GridColumn> canceledColumns(Map<String, dynamic> columnWidths) {
    return [
      GridColumn(
        width: columnWidths[OrderTableHeader.id]!,
        columnName: OrderTableHeader.id,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.id,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.comments]!,
        columnName: OrderTableHeader.comments,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.comments,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.transdate]!,
        columnName: OrderTableHeader.transdate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.transdate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryDate]!,
        columnName: OrderTableHeader.deliveryDate,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryDate,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.custCode]!,
        columnName: OrderTableHeader.custCode,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.custCode,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.customerType]!,
        columnName: OrderTableHeader.customerType,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.customerType,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.details]!,
        columnName: OrderTableHeader.details,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.details,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.subtotal]!,
        columnName: OrderTableHeader.subtotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.subtotal,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.delfee]!,
        columnName: OrderTableHeader.delfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.delfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.otherfee]!,
        columnName: OrderTableHeader.otherfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.otherfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.doctotal]!,
        columnName: OrderTableHeader.doctotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.doctotal,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.deliveryMethod]!,
        columnName: OrderTableHeader.deliveryMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.deliveryMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.paymentMethod]!,
        columnName: OrderTableHeader.paymentMethod,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.paymentMethod,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.attachments]!,
        columnName: OrderTableHeader.attachments,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.attachments,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.remarks]!,
        columnName: OrderTableHeader.remarks,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.remarks,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.address]!,
        columnName: OrderTableHeader.address,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.address,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.user]!,
        columnName: OrderTableHeader.user,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.user,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.canceledBy]!,
        columnName: OrderTableHeader.canceledBy,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.canceledBy,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.dateCanceled]!,
        columnName: OrderTableHeader.dateCanceled,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.dateCanceled,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }
}
