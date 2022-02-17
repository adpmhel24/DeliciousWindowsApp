import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../data/models/models.dart';
import '../../../../utils/currency_formater.dart';

class OrderRowsTable extends StatefulWidget {
  const OrderRowsTable({Key? key, required this.orderRows}) : super(key: key);
  final List<OrderRowModel> orderRows;

  @override
  State<OrderRowsTable> createState() => _OrderRowsTableState();
}

class _OrderRowsTableState extends State<OrderRowsTable> {
  late OrderRowDetailsDataSource _dataSource;

  late Map<String, double> columnWidths = {
    OrderRowTableHeader.id: double.nan,
    OrderRowTableHeader.itemCode: double.nan,
    OrderRowTableHeader.quantity: double.nan,
    OrderRowTableHeader.uom: double.nan,
    OrderRowTableHeader.unitPrice: double.nan,
    OrderRowTableHeader.discAmount: double.nan,
    OrderRowTableHeader.discprcnt: double.nan,
    OrderRowTableHeader.subtotal: double.nan,
    OrderRowTableHeader.comments: double.nan,
  };

  List<GridColumn> columnNames() {
    return [
      GridColumn(
        width: columnWidths[OrderRowTableHeader.id]!,
        columnName: OrderRowTableHeader.id,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.id,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderRowTableHeader.itemCode]!,
        columnName: OrderRowTableHeader.itemCode,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderRowTableHeader.itemCode,
            style: TextStyle(fontWeight: FontWeight.bold),
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
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    _dataSource = OrderRowDetailsDataSource(orders: widget.orderRows);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SfDataGrid(
        source: _dataSource,
        selectionMode: SelectionMode.single,
        navigationMode: GridNavigationMode.cell,
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
        columnWidthMode: ColumnWidthMode.auto,
        onQueryRowHeight: (details) {
          return details.getIntrinsicRowHeight(details.rowIndex);
        },
      ),
    );
  }
}

class OrderRowDetailsDataSource extends DataGridSource {
  OrderRowDetailsDataSource({required List<OrderRowModel> orders}) {
    dataGridRows = orders
        .map<DataGridRow>(
          (e) => DataGridRow(cells: [
            DataGridCell<int>(columnName: OrderRowTableHeader.id, value: e.id),
            DataGridCell<String>(
                columnName: OrderRowTableHeader.itemCode, value: e.itemCode),
            DataGridCell<double>(
                columnName: OrderRowTableHeader.quantity, value: e.quantity),
            DataGridCell<String>(
                columnName: OrderRowTableHeader.uom, value: e.uom),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.unitPrice,
              value: formatStringToDecimal(e.unitPrice.toString(),
                  hasCurrency: true),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.discAmount,
              value: formatStringToDecimal(e.discAmount.toString(),
                  hasCurrency: true),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.discprcnt,
              value: e.discprcnt!.toStringAsFixed(2),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.subtotal,
              value: formatStringToDecimal(e.subtotal.toString(),
                  hasCurrency: true),
            ),
            DataGridCell<String>(
              columnName: OrderRowTableHeader.comments,
              value: e.comments,
            ),
          ]),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == OrderRowTableHeader.id ||
                dataGridCell.columnName == OrderRowTableHeader.itemCode ||
                dataGridCell.columnName == OrderRowTableHeader.comments ||
                dataGridCell.columnName == OrderRowTableHeader.uom)
            ? Alignment.centerLeft
            : Alignment.centerRight,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
