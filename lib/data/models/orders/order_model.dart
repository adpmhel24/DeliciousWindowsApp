import 'package:delicious_windows_app/data/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends OrderHeaderModel {
  static List<OrderRowModel> _orderRowFromJson(List<dynamic> data) {
    return data.map((e) => OrderRowModel.fromJson(e)).toList();
  }

  @JsonKey(fromJson: _orderRowFromJson)
  List<OrderRowModel> rows;

  OrderModel({required this.rows}) : super();

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
