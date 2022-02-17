// import 'package:delicious_windows_app/data/models/models.dart';
// import 'package:delicious_windows_app/data/models/orders/order_model.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// import '../../../utils/currency_formater.dart';
// import '../../../widgets/info_label_row.dart';

// class ForConfirmDetails extends StatefulWidget {
//   const ForConfirmDetails({Key? key, required this.order}) : super(key: key);
//   final OrderModel order;

//   @override
//   State<ForConfirmDetails> createState() => _ForConfirmDetailsState();
// }

// class _ForConfirmDetailsState extends State<ForConfirmDetails> {
//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _discTypeController = TextEditingController();
//   final TextEditingController _dispWhseController = TextEditingController();
//   final TextEditingController _salesTypeController = TextEditingController();

//   @override
//   void initState() {
//     _idController.text = '1';
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _idController.dispose();
//     _discTypeController.dispose();
//     _dispWhseController.dispose();
//     _salesTypeController.dispose();
//     super.dispose();
//   }

//   final List<String> _dispatchingWhse = const [
//     "LC Productoin",
//     "LC Whse",
//     "E Rod"
//   ];

//   String? comboBoxValue;

//   @override
//   Widget build(BuildContext context) {
//     return Mica(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InfoLabelRow(
//                         label: "Order Id:",
//                         child: Text(
//                           widget.order.id.toString(),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       InfoLabelRow(
//                         label: "Transaction Date:",
//                         child: Text(
//                           DateFormat("MM/dd/yyyy")
//                               .format(widget.order.transdate ?? DateTime.now()),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       InfoLabelRow(
//                         label: "Delivery Date:",
//                         child: Text(
//                           DateFormat("MM/dd/yyyy").format(
//                               widget.order.deliveryDate ?? DateTime.now()),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       InfoLabelRow(
//                         label: "Customer Code:",
//                         child: Text(
//                           widget.order.custCode ?? "",
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 50.w,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       InfoLabelRow(
//                         label: "Dispatching Whse:",
//                         child: Combobox<String>(
//                           placeholder: const Text('Select Warehouse'),
//                           // isExpanded: true,
//                           items: _dispatchingWhse
//                               .map(
//                                 (e) => ComboboxItem(
//                                   child: Text(e),
//                                   value: e,
//                                 ),
//                               )
//                               .toList(),
//                           value: _dispWhseController.text.isEmpty
//                               ? null
//                               : _dispWhseController.text,
//                           onChanged: (value) {
//                             if (value != null) {
//                               setState(() => _dispWhseController.text = value);
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       InfoLabelRow(
//                         label: "Discount Type:",
//                         child: Combobox<String>(
//                           placeholder: const Text('Select Discount Type'),
//                           // isExpanded: true,
//                           items: _dispatchingWhse
//                               .map(
//                                 (e) => ComboboxItem(
//                                   child: Text(e),
//                                   value: e,
//                                 ),
//                               )
//                               .toList(),
//                           value: comboBoxValue,
//                           onChanged: (value) {
//                             if (value != null) {
//                               setState(() => comboBoxValue = value);
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       InfoLabelRow(
//                         label: "Sales Type:",
//                         child: Combobox<String>(
//                           placeholder: const Text('Select Sales Type'),
//                           // isExpanded: true,
//                           items: _dispatchingWhse
//                               .map(
//                                 (e) => ComboboxItem(
//                                   child: Text(e),
//                                   value: e,
//                                 ),
//                               )
//                               .toList(),
//                           value: comboBoxValue,
//                           onChanged: (value) {
//                             if (value != null) {
//                               setState(() => comboBoxValue = value);
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             TextBox(
//               enabled: false,
//               controller: TextEditingController(text: '1'),
//               prefix: const Text("Order Id:"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrdersDataSource extends DataGridSource {
//   OrdersDataSource(ordersContext, {required List<OrderRowModel> orders}) {
//     dataGridRows = orders
//         .map<DataGridRow>(
//           (e) => DataGridRow(cells: [
//             DataGridCell<int>(columnName: OrderRowTableHeader.id, value: e.id),
//             DataGridCell<String>(
//                 columnName: OrderRowTableHeader.itemCode, value: e.itemCode),
//             DataGridCell<double>(
//                 columnName: OrderRowTableHeader.quantity, value: e.quantity),
//             DataGridCell<String>(
//                 columnName: OrderRowTableHeader.uom, value: e.uom),
//             DataGridCell<String>(
//               columnName: OrderRowTableHeader.unitPrice,
//               value: formatStringToDecimal(e.unitPrice.toString(),
//                   hasCurrency: true),
//             ),
//             DataGridCell<String>(
//               columnName: OrderRowTableHeader.discAmount,
//               value: formatStringToDecimal(e.discAmount.toString(),
//                   hasCurrency: true),
//             ),
//             DataGridCell<String>(
//               columnName: OrderRowTableHeader.subtotal,
//               value: formatStringToDecimal(e.subtotal.toString(),
//                   hasCurrency: true),
//             ),
//             DataGridCell<String>(
//               columnName: OrderRowTableHeader.comments,
//               value: e.comments,
//             ),
//           ]),
//         )
//         .toList();
//   }

//   List<DataGridRow> dataGridRows = [];

//   @override
//   List<DataGridRow> get rows => dataGridRows;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((dataGridCell) {
//       return Container(
//         alignment: (dataGridCell.columnName == OrderRowTableHeader.id ||
//                 dataGridCell.columnName == OrderRowTableHeader.itemCode ||
//                 dataGridCell.columnName == OrderRowTableHeader.comments ||
//                 dataGridCell.columnName == OrderRowTableHeader.uom)
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         padding: const EdgeInsets.all(16.0),
//         child: Text(dataGridCell.value.toString()),
//       );
//     }).toList());
//   }
// }
