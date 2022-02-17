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
  late OrderRowTableDataSource _dataSource;

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
            overflow: TextOverflow.ellipsis,
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
    _dataSource = OrderRowTableDataSource(widget.orderRows);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 71, 61, 61))),
      child: SfDataGrid(
        source: _dataSource,
        allowEditing: true,
        editingGestureType: EditingGestureType.tap,
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

class OrderRowTableDataSource extends DataGridSource {
  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();
  List<DataGridRow> dataGridRows = [];
  final List<OrderRowModel> _orders;

  OrderRowTableDataSource(this._orders) {
    dataGridRows = _orders
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

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow.getCells().firstWhere(
        (DataGridCell dataGridCell) =>
            dataGridCell.columnName == column.columnName);

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == OrderRowTableHeader.discAmount) {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: OrderRowTableHeader.discAmount, value: newCellValue);
      _orders[dataRowIndex].discAmount = newCellValue as double;
    } else if (column.columnName == OrderRowTableHeader.discprcnt) {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: OrderRowTableHeader.discprcnt, value: newCellValue);
      _orders[dataRowIndex].discprcnt = newCellValue;
    } else if (column.columnName == OrderRowTableHeader.comments) {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: OrderRowTableHeader.comments, value: newCellValue);
      _orders[dataRowIndex].comments = newCellValue as String;
    }
  }

  @override
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    // Return false, to retain in edit mode.
    return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isTextAlignRight =
        column.columnName == OrderRowTableHeader.discAmount ||
            column.columnName == OrderRowTableHeader.discprcnt;

    final bool isNumericKeyBoardType =
        column.columnName == OrderRowTableHeader.discAmount ||
            column.columnName == OrderRowTableHeader.discprcnt;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment:
          isTextAlignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: TextFormBox(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isTextAlignRight ? TextAlign.right : TextAlign.left,
        keyboardType:
            isNumericKeyBoardType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericKeyBoardType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onFieldSubmitted: (String value) {
          // In Mobile Platform.
          // Call [CellSubmit] callback to fire the canSubmitCell and
          // onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }
}
