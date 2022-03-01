import 'package:delicious_windows_app/presentations/screens/orders_screen/order_details/order_bloc/bloc.dart';
import 'package:delicious_windows_app/presentations/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../../../../data/repositories/repositories.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/remarks_dialog.dart';
import '/data/models/models.dart';
import '/presentations/screens/orders_screen/orders_bloc/blocs.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/constant.dart';
import '../../../utils/currency_formater.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_large_dialog.dart';
import '../order_details/order_details_edittable/order_details.dart';

class ForConfirmation extends StatefulWidget {
  const ForConfirmation(
      {Key? key,
      required this.gridKey,
      required this.startDate,
      required this.endDate})
      : super(key: key);
  final GlobalKey<SfDataGridState> gridKey;
  final DateTime startDate;
  final DateTime endDate;

  @override
  State<ForConfirmation> createState() => _ForConfirmationState();
}

class _ForConfirmationState extends State<ForConfirmation> {
  late OrdersDataSource _ordersDataSource;

  @override
  void initState() {
    context
        .read<OrdersBloc>()
        .add(FetchForConfirmationOrders(widget.startDate, widget.endDate));
    super.initState();
  }

  late Map<String, double> columnWidths = {
    OrderTableHeader.id: double.nan,
    OrderTableHeader.transdate: double.nan,
    OrderTableHeader.deliveryDate: double.nan,
    OrderTableHeader.custCode: double.nan,
    OrderTableHeader.details: double.nan,
    OrderTableHeader.subtotal: double.nan,
    OrderTableHeader.delfee: double.nan,
    OrderTableHeader.otherfee: double.nan,
    OrderTableHeader.doctotal: double.nan,
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
        width: columnWidths[OrderTableHeader.subtotal]!,
        columnName: OrderTableHeader.subtotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.subtotal,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.delfee]!,
        columnName: OrderTableHeader.delfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.delfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.otherfee]!,
        columnName: OrderTableHeader.otherfee,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.otherfee,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GridColumn(
        width: columnWidths[OrderTableHeader.doctotal]!,
        columnName: OrderTableHeader.doctotal,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            OrderTableHeader.doctotal,
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<OrdersBloc, OrdersState>(
            listener: (_, state) {
              if (state is OrdersLoading) {
                CustomDialog.loading(context);
              } else if (state is OrdersLoaded) {
                Navigator.of(context).pop();
              } else if (state is ErrorState) {
                CustomDialog.error(context, message: state.messsage);
              }
            },
          ),
          BlocListener<OrderBloc, OrderState>(
            listener: (_, state) {
              if (state is OrderCancelSubmitting) {
                CustomDialog.loading(context);
              } else if (state is OrderCanceledSuccessfully) {
                widget.gridKey.currentState!.refresh(false);
                CustomDialog.success(context,
                    message: "Successfully canceled",
                    actions: [
                      Button(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ]);
              } else if (state is OrderCancelError) {
                CustomDialog.error(context, message: state.message);
              }
            },
          ),
        ],
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (_, state) {
            if (state is OrdersLoaded) {
              _ordersDataSource =
                  OrdersDataSource(context, orders: state.orders);

              return ChangeNotifierProvider<OrderRepository>(
                create: (context) => OrderRepository(),
                child: Builder(
                  builder: (context) {
                    return SfDataGrid(
                      key: widget.gridKey,
                      source: _ordersDataSource,
                      selectionMode: SelectionMode.single,
                      navigationMode: GridNavigationMode.cell,
                      frozenColumnsCount: 1,
                      allowColumnsResizing: true,
                      onColumnResizeUpdate:
                          (ColumnResizeUpdateDetails details) {
                        setState(() {
                          columnWidths[details.column.columnName] =
                              details.width;
                        });
                        return true;
                      },
                      allowPullToRefresh: true,
                      isScrollbarAlwaysShown: true,
                      columns: columnNames(),
                      columnWidthMode: ColumnWidthMode.auto,
                      allowSwiping: true,
                      swipeMaxOffset: 100.0,
                      startSwipeActionsBuilder: (BuildContext context,
                          DataGridRow row, int rowIndex) {
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
                                                submitRemarks:
                                                    (String remarks) {
                                                  context.read<OrderBloc>().add(
                                                        SubmitCancelOrder(
                                                            orderId: id,
                                                            orderRepo: Provider
                                                                .of<OrderRepository>(
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
                                child: ChangeNotifierProvider.value(
                                  value: Provider.of<OrderRepository>(context),
                                  child: FutureBuilder(
                                    future:
                                        Provider.of<OrderRepository>(context)
                                            .fetchOrderById(id),
                                    builder: ((_, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.active:
                                        case ConnectionState.waiting:
                                          return const Center(
                                            child: ProgressRing(),
                                          );
                                        case ConnectionState.done:
                                          if (snapshot.hasError) {
                                            return const Text(
                                                'Error Loading Data.');
                                          }
                                          return Consumer<OrderRepository>(
                                              builder: (_, order, child) {
                                            return OrderDetails(
                                              orderRepo: order,
                                              fetchOrders: () => widget
                                                  .gridKey.currentState!
                                                  .refresh(false),
                                              orderBloc:
                                                  context.read<OrderBloc>(),
                                            );
                                          });

                                        default:
                                          return Container();
                                      }
                                    }),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
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
                  columnName: OrderTableHeader.subtotal,
                  value: formatStringToDecimal(e.subtotal.toString(),
                      hasCurrency: true)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.delfee,
                  value: formatStringToDecimal(e.delfee.toString(),
                      hasCurrency: true)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.otherfee,
                  value: formatStringToDecimal(e.otherfee.toString(),
                      hasCurrency: true)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.doctotal,
                  value: formatStringToDecimal(e.doctotal.toString(),
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
    _ordersContext.read<OrdersBloc>().add(const FetchForConfirmationOrders());
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
