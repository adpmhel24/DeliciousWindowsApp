import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../utils/currency_formater.dart';

class OrderRowTablReadOnly extends StatefulWidget {
  const OrderRowTablReadOnly({Key? key, required this.rows}) : super(key: key);

  final List<OrderRowModel> rows;

  @override
  State<OrderRowTablReadOnly> createState() => _OrderRowTablReadOnlyState();
}

class _OrderRowTablReadOnlyState extends State<OrderRowTablReadOnly> {
  late DataGridController _dataGridController;

  late Map<String, double> columnWidths = {
    OrderRowTableHeader.id: double.nan,
    OrderRowTableHeader.itemCode: double.nan,
    OrderRowTableHeader.quantity: double.nan,
    OrderRowTableHeader.uom: double.nan,
    OrderRowTableHeader.unitPrice: double.nan,
    OrderRowTableHeader.gross: double.nan,
    OrderRowTableHeader.discAmount: double.nan,
    OrderRowTableHeader.discprcnt: double.nan,
    OrderRowTableHeader.subtotal: double.nan,
    OrderRowTableHeader.comments: double.nan,
  };

  List<GridColumn> columnNames() {
    return [
      GridColumn(
        width: columnWidths[OrderRowTableHeader.itemCode]!,
        columnName: OrderRowTableHeader.itemCode,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.itemCode,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.quantity]!,
        columnName: OrderRowTableHeader.quantity,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.quantity,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.uom]!,
        columnName: OrderRowTableHeader.uom,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.uom,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.unitPrice]!,
        columnName: OrderRowTableHeader.unitPrice,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.unitPrice,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.gross]!,
        columnName: OrderRowTableHeader.gross,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.gross,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.discprcnt]!,
        columnName: OrderRowTableHeader.discprcnt,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.discprcnt,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.discAmount]!,
        columnName: OrderRowTableHeader.discAmount,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.discAmount,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.subtotal]!,
        columnName: OrderRowTableHeader.subtotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.subtotal,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.comments]!,
        columnName: OrderRowTableHeader.comments,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.comments,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    // _dataSource =

    _dataGridController = DataGridController();

    super.initState();
  }

  @override
  void dispose() {
    _dataGridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrderRowDetailsDataSource _dataSource =
        OrderRowDetailsDataSource(widget.rows);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Acrylic(
        luminosityAlpha: 10,
        tintAlpha: 50,
        child: SfDataGrid(
          source: _dataSource,
          selectionMode: SelectionMode.single,
          navigationMode: GridNavigationMode.cell,
          controller: _dataGridController,
          frozenColumnsCount: 1,
          allowColumnsResizing: true,
          onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
            setState(() {
              columnWidths[details.column.columnName] = details.width;
            });
            return true;
          },
          isScrollbarAlwaysShown: true,
          columns: columnNames(),
          columnWidthMode: ColumnWidthMode.fill,
          onQueryRowHeight: (details) {
            return details.getIntrinsicRowHeight(details.rowIndex);
          },
        ),
      ),
    );
  }
}

class OrderRowDetailsDataSource extends DataGridSource {
  OrderRowDetailsDataSource(this._orderRows) {
    dataGridRows = _orderRows
        .map<DataGridRow>(
          (e) => DataGridRow(cells: [
            DataGridCell<String>(
                columnName: OrderRowTableHeader.itemCode, value: e.itemCode),
            DataGridCell<double>(
                columnName: OrderRowTableHeader.quantity, value: e.quantity),
            DataGridCell<String>(
                columnName: OrderRowTableHeader.uom, value: e.uom),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.unitPrice,
              value: formatStringToDecimal(
                e.unitPrice.toString(),
              ),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.gross,
              value: formatStringToDecimal(
                e.gross.toString(),
              ),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.discprcnt,
              value: e.discprcnt!.toStringAsFixed(2),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.discAmount,
              value: formatStringToDecimal(
                e.discAmount.toString(),
              ),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.subtotal,
              value: formatStringToDecimal(
                e.subtotal.toString(),
              ),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.comments,
              value: e.comments,
            ),
          ]),
        )
        .toList();
  }
  final List<OrderRowModel> _orderRows;

  List<DataGridRow> dataGridRows = [];

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == OrderRowTableHeader.itemCode ||
                dataGridCell.columnName == OrderRowTableHeader.comments)
            ? Alignment.centerLeft
            : dataGridCell.columnName == OrderRowTableHeader.uom
                ? Alignment.center
                : Alignment.centerRight,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
