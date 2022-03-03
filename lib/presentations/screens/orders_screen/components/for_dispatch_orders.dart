import 'package:delicious_windows_app/data/models/models.dart';
import 'package:delicious_windows_app/presentations/screens/orders_screen/orders_bloc/blocs.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../data/repositories/order_repo.dart';
import '../../../utils/constant.dart';
import '../../../utils/currency_formater.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_large_dialog.dart';
import '../../../widgets/remarks_dialog.dart';
import '../order_details/order_bloc/bloc.dart';
import '../order_details/order_details_read_only/order_details_read_only.dart';

class ForDispatch extends StatefulWidget {
  const ForDispatch(
      {Key? key,
      required this.gridKey,
      required this.startDate,
      required this.endDate})
      : super(key: key);
  final GlobalKey<SfDataGridState> gridKey;
  final DateTime startDate;
  final DateTime endDate;

  @override
  State<ForDispatch> createState() => _ForDispatchState();
}

class _ForDispatchState extends State<ForDispatch> {
  late OrdersDataSource _ordersDataSource;

  @override
  void initState() {
    context
        .read<OrdersBloc>()
        .add(FetchForDispatchOrders(widget.startDate, widget.endDate));
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
    OrderTableHeader.paymentStatus: double.nan,
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
        width: columnWidths[OrderTableHeader.paymentStatus]!,
        columnName: OrderTableHeader.paymentStatus,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.paymentStatus,
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
            _ordersDataSource = OrdersDataSource(context,
                orders: state.orders,
                startDate: widget.startDate,
                endDate: widget.endDate);

            return BlocListener<OrderBloc, OrderState>(
              listenWhen: (previous, current) =>
                  current is FetchingOrderState ||
                  current is OrderLoadedState ||
                  current is OrderCancelSubmitting ||
                  current is OrderCanceledSuccessfully ||
                  current is OrderCancelError ||
                  current is FetchingErrorState,
              listener: (context, state) {
                if (state is FetchingOrderState) {
                  CustomDialog.loading(context);
                } else if (state is OrderLoadedState) {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) {
                      return LargeDialog(
                        constraints: Responsive.largeScreen(context)
                            ? BoxConstraints(
                                maxWidth: SizeConfig.screenWidth * .8,
                                maxHeight: SizeConfig.screenHeight * .9)
                            : null,
                        child: OrderDetailsReadOnly(
                          orderModel: state.orderModel,
                          refreshOrders: () =>
                              widget.gridKey.currentState!.refresh(false),
                          orderBloc: context.read<OrderBloc>(),
                          view: 'dispatched',
                        ),
                      );
                    },
                  );
                } else if (state is FetchingErrorState) {
                  CustomDialog.error(context, message: state.message);
                } else if (state is OrderCancelSubmitting) {
                  CustomDialog.loading(context);
                } else if (state is OrderCanceledSuccessfully) {
                  CustomDialog.success(context,
                      message: "Successfully canceled",
                      actions: [
                        Button(
                            child: const Text('Okay'),
                            onPressed: () {
                              widget.gridKey.currentState!.refresh(false);

                              Navigator.of(context).pop();
                            }),
                      ]);
                } else if (state is OrderCancelError) {
                  CustomDialog.error(context, message: state.message);
                }
              },
              child: SfDataGrid(
                key: widget.gridKey,
                source: _ordersDataSource,
                allowSorting: true,
                allowMultiColumnSorting: true,
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
                allowSwiping: true,
                swipeMaxOffset: 100.0,
                startSwipeActionsBuilder:
                    (BuildContext context, DataGridRow row, int rowIndex) {
                  return GestureDetector(
                    onTap: () {
                      int id = _ordersDataSource.dataGridRows[rowIndex]
                          .getCells()[0]
                          .value;
                      CustomDialog.warning(context,
                          message: "Are you sure you want to cancel?",
                          actions: [
                            Button(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            Button(
                                child: const Text('Okay'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return DialogRemarks(
                                          submitRemarks: (String remarks) {
                                            context.read<OrderBloc>().add(
                                                  SubmitCancelOrder(
                                                      orderId: id,
                                                      orderRepo: Provider.of<
                                                              OrderRepository>(
                                                          context,
                                                          listen: false),
                                                      data: {
                                                        "comment": remarks
                                                      }),
                                                );
                                          },
                                        );
                                      });
                                }),
                          ]);
                    },
                    child: Container(
                      color: Colors.red.normal,
                      child: const Center(
                        child: Icon(FluentIcons.delete),
                      ),
                    ),
                  );
                },
                onQueryRowHeight: (details) {
                  return details.getIntrinsicRowHeight(details.rowIndex);
                },
                onCellDoubleTap: (
                  details,
                ) async {
                  if (details.rowColumnIndex.rowIndex > 0) {
                    int id = _ordersDataSource
                        .dataGridRows[details.rowColumnIndex.rowIndex - 1]
                        .getCells()[0]
                        .value;
                    context.read<OrderBloc>().add(FetchOrderDetails(id));
                  }
                },
              ),
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
  final DateTime? startDate;
  final DateTime? endDate;

  OrdersDataSource(
    ordersContext, {
    required List<OrderHeaderModel> orders,
    this.startDate,
    this.endDate,
  }) {
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
                  columnName: OrderTableHeader.paymentStatus,
                  value: e.paymentStatus),
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
    _ordersContext
        .read<OrdersBloc>()
        .add(FetchForDispatchOrders(startDate, endDate));
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
