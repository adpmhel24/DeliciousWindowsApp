import 'package:delicious_windows_app/data/models/models.dart';
import 'package:delicious_windows_app/presentations/screens/orders_screen/orders_bloc/blocs.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/constant.dart';
import '../../../utils/currency_formater.dart';
import '../../../widgets/custom_dialog.dart';

class ForDispatch extends StatefulWidget {
  const ForDispatch({Key? key, required this.gridKey}) : super(key: key);
  final GlobalKey<SfDataGridState> gridKey;

  @override
  State<ForDispatch> createState() => _ForDispatchState();
}

class _ForDispatchState extends State<ForDispatch> {
  late OrdersDataSource _ordersDataSource;

  @override
  void initState() {
    context.read<OrdersBloc>().add(FetchForDispatchOrders());
    super.initState();
  }

  late Map<String, double> columnWidths = {
    OrderTableHeader.id: double.nan,
    OrderTableHeader.transdate: double.nan,
    OrderTableHeader.deliveryDate: double.nan,
    OrderTableHeader.custCode: double.nan,
    OrderTableHeader.details: double.nan,
    OrderTableHeader.balance: double.nan,
    OrderTableHeader.deliveryMethod: double.nan,
    OrderTableHeader.paymentMethod: double.nan,
    OrderTableHeader.remarks: double.nan,
    OrderTableHeader.address: double.nan,
    OrderTableHeader.user: double.nan,
  };

  List<GridColumn> columnNames() {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constant.contentBackGroundColor,
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (_, state) {
          if (state is OrdersLoading) {
            CustomDialog.loading(context);
          } else if (state is OrdersLoaded) {
            Navigator.of(context).pop();
          } else if (state is ErrorState) {
            CustomDialog.error(context, message: state.messsage);
          }
        },
        builder: (_, state) {
          if (state is OrdersLoaded) {
            _ordersDataSource = OrdersDataSource(context, orders: state.orders);

            return SfDataGrid(
              key: widget.gridKey,
              source: _ordersDataSource,
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
              allowPullToRefresh: true,
              isScrollbarAlwaysShown: true,
              columns: columnNames(),
              columnWidthMode: ColumnWidthMode.auto,
              onQueryRowHeight: (details) {
                return details.getIntrinsicRowHeight(details.rowIndex);
              },
            );
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }
}

class OrdersDataSource extends DataGridSource {
  late BuildContext _ordersContext;

  OrdersDataSource(ordersContext, {required List<OrderHeaderModel> orders}) {
    _ordersContext = ordersContext;
    dataGridRows = orders
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: OrderTableHeader.id, value: e.id),
              DataGridCell<String>(
                  columnName: OrderTableHeader.transdate,
                  value: DateFormat("MM/dd/yyyy").format(e.transdate!)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.deliveryDate,
                  value: DateFormat("MM/dd/yyyy").format(e.deliveryDate!)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.custCode, value: e.custCode),
              DataGridCell<String>(
                  columnName: OrderTableHeader.details, value: e.details),
              DataGridCell<String>(
                  columnName: OrderTableHeader.balance,
                  value: formatStringToDecimal(e.balance.toString(),
                      hasCurrency: true)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.deliveryMethod,
                  value: e.deliveryMethod),
              DataGridCell<String>(
                  columnName: OrderTableHeader.paymentMethod,
                  value: e.paymentMethod),
              DataGridCell<String>(
                  columnName: OrderTableHeader.remarks, value: e.remarks),
              DataGridCell<String>(
                  columnName: OrderTableHeader.address, value: e.address),
              DataGridCell<String>(
                  columnName: OrderTableHeader.user, value: e.user),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _ordersContext.read<OrdersBloc>().add(FetchForDispatchOrders());
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'custCode')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
