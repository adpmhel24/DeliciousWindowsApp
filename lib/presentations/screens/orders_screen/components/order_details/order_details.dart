import 'package:delicious_windows_app/data/models/orders/order_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/info_label_row.dart';
import 'order_rows.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _discTypeController = TextEditingController();
  final TextEditingController _dispWhseController = TextEditingController();
  final TextEditingController _salesTypeController = TextEditingController();

  @override
  void initState() {
    _idController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _discTypeController.dispose();
    _dispWhseController.dispose();
    _salesTypeController.dispose();
    super.dispose();
  }

  final List<String> _dispatchingWhse = const [
    "LC Productoin",
    "LC Whse",
    "E Rod"
  ];

  String? comboBoxValue;

  @override
  Widget build(BuildContext context) {
    return Mica(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoLabelRow(
                        label: "Order Id:",
                        child: Text(
                          widget.order.id.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InfoLabelRow(
                        label: "Transaction Date:",
                        child: Text(
                          DateFormat("MM/dd/yyyy")
                              .format(widget.order.transdate ?? DateTime.now()),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InfoLabelRow(
                        label: "Delivery Date:",
                        child: Text(
                          DateFormat("MM/dd/yyyy").format(
                              widget.order.deliveryDate ?? DateTime.now()),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InfoLabelRow(
                        label: "Customer Code:",
                        child: Text(
                          widget.order.custCode ?? "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 50.w,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InfoLabelRow(
                        label: "Dispatching Whse:",
                        child: Combobox<String>(
                          placeholder: const Text('Select Warehouse'),
                          // isExpanded: true,
                          items: _dispatchingWhse
                              .map(
                                (e) => ComboboxItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          value: _dispWhseController.text.isEmpty
                              ? null
                              : _dispWhseController.text,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _dispWhseController.text = value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InfoLabelRow(
                        label: "Discount Type:",
                        child: Combobox<String>(
                          placeholder: const Text('Select Discount Type'),
                          // isExpanded: true,
                          items: _dispatchingWhse
                              .map(
                                (e) => ComboboxItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          value: comboBoxValue,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => comboBoxValue = value);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InfoLabelRow(
                        label: "Sales Type:",
                        child: Combobox<String>(
                          placeholder: const Text('Select Sales Type'),
                          // isExpanded: true,
                          items: _dispatchingWhse
                              .map(
                                (e) => ComboboxItem(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          value: comboBoxValue,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => comboBoxValue = value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Flexible(
              child: OrderRowsTable(
                orderRows: widget.order.rows,
              ),
            )
          ],
        ),
      ),
    );
  }
}
