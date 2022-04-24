import 'package:fluent_ui/fluent_ui.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'customer_address_model.dart';
import 'customer_base_model.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel extends CustomerBaseModel {
  static List<CustomerAddressModel>? _addressesFromJson(List<dynamic>? data) {
    if (data != null) {
      return data.map((e) => CustomerAddressModel.fromJson(e)).toList();
    }
    return null;
  }

  static List<Map<String, dynamic>>? _addressesToJson(
      List<CustomerAddressModel>? addresses) {
    if (addresses != null) {
      return addresses.map((e) => e.toJson()).toList();
    }
    return null;
  }

  @JsonKey(fromJson: _addressesFromJson, toJson: _addressesToJson)
  List<CustomerAddressModel>? details;

  CustomerModel({
    this.details,
  }) : super();

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

class CustomerTable {
  static const lineCount = "#";
  static const custCode = "Customer Code";
  static const custName = "Customer Name";
  static const custType = "Customer Type";
  static const firstName = "First Name";
  static const lastName = "Last Name";
  static const contactNumber = "Contact No.";
  static const email = "Email Address";
  static const salesDisc = "Sales Discount";
  static const pickupDisc = "Pickup Discount";
  static const user = "Username";

  static Map<String, double> columnWidths = {
    lineCount: 65,
    custCode: double.nan,
    custName: double.nan,
    custType: double.nan,
    firstName: double.nan,
    lastName: double.nan,
    contactNumber: double.nan,
    email: double.nan,
    salesDisc: 100,
    pickupDisc: 100,
    user: 200,
  };

  static List<GridColumn> get columns => [
        GridColumn(
          width: columnWidths[lineCount]!,
          columnName: lineCount,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              lineCount,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[custCode]!,
          columnName: custCode,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              custCode,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[custName]!,
          columnName: custName,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              custName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[custType]!,
          columnName: custType,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              custType,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[firstName]!,
          columnName: firstName,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              firstName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[lastName]!,
          columnName: lastName,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              lastName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[contactNumber]!,
          columnName: contactNumber,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              contactNumber,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[email]!,
          columnName: email,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              email,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[salesDisc]!,
          columnName: salesDisc,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              salesDisc,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[pickupDisc]!,
          columnName: pickupDisc,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              pickupDisc,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths[user]!,
          columnName: user,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              user,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ];
}
