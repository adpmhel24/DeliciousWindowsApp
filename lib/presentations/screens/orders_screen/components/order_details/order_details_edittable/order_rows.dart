import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../utils/currency_formater.dart';

class OrderRowsTable extends StatefulWidget {
  const OrderRowsTable({Key? key}) : super(key: key);

  @override
  State<OrderRowsTable> createState() => _OrderRowsTableState();
}

class _OrderRowsTableState extends State<OrderRowsTable> {
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
        allowEditing: false,
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
        allowEditing: false,
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
        allowEditing: false,
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
        allowEditing: false,
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
        allowEditing: false,
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
        allowEditing: false,
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
        OrderRowDetailsDataSource(Provider.of<OrderRepository>(context));
    return Container(
      margin: const EdgeInsets.all(10),
      child: Acrylic(
        luminosityAlpha: 10,
        tintAlpha: 50,
        child: SfDataGrid(
          source: _dataSource,
          allowEditing: true,
          editingGestureType: EditingGestureType.doubleTap,
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
  OrderRowDetailsDataSource(this._ordersRepo) {
    dataGridRows = _ordersRepo.order.rows
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
  final OrderRepository _ordersRepo;

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

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }

    if (column.columnName == OrderRowTableHeader.discAmount) {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
              columnName: OrderRowTableHeader.discAmount, value: newCellValue);

      _ordersRepo.updateDiscountAmount(dataRowIndex, newCellValue);

      _ordersRepo.order.rows[dataRowIndex].discAmount = newCellValue as double;
    }
    // Discount Percentage
    else if (column.columnName == OrderRowTableHeader.discprcnt) {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
              columnName: OrderRowTableHeader.discprcnt, value: newCellValue);

      _ordersRepo.updateDiscountPercentage(dataRowIndex, newCellValue);
      _ordersRepo.order.rows[dataRowIndex].discprcnt = newCellValue as double;
    }
    // Comments
    else if (column.columnName == OrderRowTableHeader.comments) {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<String>(
              columnName: OrderRowTableHeader.comments, value: newCellValue);
      _ordersRepo.order.rows[dataRowIndex].comments = newCellValue as String;
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

    final bool isNumericType =
        column.columnName == OrderRowTableHeader.discAmount ||
            column.columnName == OrderRowTableHeader.discprcnt;
    // Holds regular expression pattern based on the column type.
    final RegExp regExp = _getRegExp(isNumericType, column.columnName);

    return Container(
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextFormBox(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        autocorrect: false,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(regExp)
        ],
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue =
                  double.parse(double.parse(value).toStringAsFixed(2));
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onFieldSubmitted: (String value) {
          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  RegExp _getRegExp(bool isNumericKeyBoard, String columnName) {
    return isNumericKeyBoard ? RegExp("[0-9.]") : RegExp('.');
  }
}
