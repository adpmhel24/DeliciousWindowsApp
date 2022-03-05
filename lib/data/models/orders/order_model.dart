import '/data/models/models.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends OrderHeaderModel {
  static List<OrderRowModel> _orderRowFromJson(List<dynamic> data) {
    return data.map((e) => OrderRowModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> _orderRowToJson(
      List<OrderRowModel> orderRows) {
    return orderRows.map((e) => e.toJson()).toList();
  }

  @JsonKey(fromJson: _orderRowFromJson, toJson: _orderRowToJson)
  List<OrderRowModel> rows;

  OrderModel({required this.rows}) : super();

  Map<String, dynamic> toJsonSales() {
    final Map<String, dynamic> data = <String, dynamic>{
      "header": {},
      "rows": [],
    };

    data["header"]["base_id"] = id;
    data["header"]["transdate"] =
        DateFormat('yyyy/MM/dd hh:mm').format(DateTime.now()).toString();
    data["header"]["transtype"] = salestype;
    data["header"]["disctype"] = disctype;
    data["header"]["cust_code"] = custCode;
    data["header"]["delfee"] = delfee;
    data["header"]["otherfee"] = otherfee;
    data["header"]["discprcnt"] = 0.00;
    data["header"]["dispatching_whse"] = dispatchingWhse;
    data["header"]["hashed_id"] =
        const Uuid().v5(Uuid.NAMESPACE_URL, DateTime.now().toIso8601String());
    data["header"]["remarks"] = "${remarks ?? ''} Based on Order Id: $id";
    data["header"]["tenderamt"] = 0.00;
    data["rows"] = rows.map((e) {
      return {
        "base_id": e.id,
        "item_code": e.itemCode,
        "quantity": e.quantity,
        "uom": e.uom,
        "unit_price": e.unitPrice,
        "discprcnt": e.discprcnt,
        "disc_amount": e.discAmount,
      };
    }).toList();

    return data;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
