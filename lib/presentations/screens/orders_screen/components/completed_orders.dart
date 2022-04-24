import 'package:badges/badges.dart';

import '../order_attachment/order_attachment_viewer.dart';
import '/data/models/models.dart';
import '/presentations/screens/orders_screen/orders_bloc/blocs.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../utils/constant.dart';
import '../../../utils/currency_formater.dart';
import '../../../utils/responsive.dart';
import '../../../utils/size_config.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_large_dialog.dart';
import './order_details/order_bloc/bloc.dart';
import './order_details/order_details_read_only/order_details_read_only.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({
    Key? key,
    required this.gridKey,
    this.startDate,
    this.endDate,
  }) : super(key: key);
  final GlobalKey<SfDataGridState> gridKey;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  State<CompletedOrders> createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  late OrdersDataSource _ordersDataSource;

  @override
  void initState() {
    context
        .read<OrdersBloc>()
        .add(FetchCompletedOrders(widget.startDate, widget.endDate));
    super.initState();
  }

  late Map<String, double> columnWidths = {
    OrderTableHeader.id: double.nan,
    OrderTableHeader.transdate: double.nan,
    OrderTableHeader.deliveryDate: double.nan,
    OrderTableHeader.custCode: double.nan,
    OrderTableHeader.customerType: double.nan,
    OrderTableHeader.details: double.nan,
    OrderTableHeader.subtotal: double.nan,
    OrderTableHeader.delfee: double.nan,
    OrderTableHeader.otherfee: double.nan,
    OrderTableHeader.doctotal: double.nan,
    OrderTableHeader.deliveryMethod: double.nan,
    OrderTableHeader.paymentMethod: double.nan,
    OrderTableHeader.attachments: 100.0,
    OrderTableHeader.remarks: double.nan,
    OrderTableHeader.address: double.nan,
    OrderTableHeader.user: double.nan,
    OrderTableHeader.salesReference: double.nan,
    OrderTableHeader.dispatchedBy: double.nan,
    OrderTableHeader.dateDispatched: double.nan,
  };

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
                          view: 'completed',
                        ),
                      );
                    },
                  );
                } else if (state is FetchingErrorState) {
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
                columns: OrderTableHeader.completedColumns(columnWidths),
                columnWidthMode: ColumnWidthMode.auto,
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
  DateTime? startDate;
  DateTime? endDate;

  OrdersDataSource(ordersContext,
      {required List<OrderHeaderModel> orders, this.startDate, this.endDate}) {
    _ordersContext = ordersContext;
    dataGridRows = orders
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: OrderTableHeader.id, value: e.id),
              DataGridCell<String>(
                  columnName: OrderTableHeader.transdate,
                  value: DateFormat("MM/dd/yyyy HH:MM").format(e.transdate!)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.deliveryDate,
                  value: DateFormat("MM/dd/yyyy").format(e.deliveryDate!)),
              DataGridCell<String>(
                  columnName: OrderTableHeader.salesReference,
                  value: e.salesReference),
              DataGridCell<String>(
                  columnName: OrderTableHeader.custCode, value: e.custCode),
              DataGridCell<String>(
                  columnName: OrderTableHeader.customerType,
                  value: e.customerType),
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
              DataGridCell<Widget>(
                columnName: OrderTableHeader.attachments,
                value: IconButton(
                  icon: Badge(
                    badgeContent: Text(
                      "${e.attachmentCount ?? 0}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    badgeColor: Colors.green.lighter,
                    child: const Icon(
                      FluentIcons.file_image,
                      size: 20,
                    ),
                  ),
                  onPressed: e.attachmentCount == 0
                      ? null
                      : () {
                          showDialog(
                              context: _ordersContext,
                              barrierDismissible: true,
                              builder: (_) {
                                return LargeDialog(
                                  child: OrderAttachmentViewer(
                                    orderId: e.id!,
                                  ),
                                );
                              });
                        },
                ),
              ),
              DataGridCell<String>(
                  columnName: OrderTableHeader.remarks, value: e.remarks),
              DataGridCell<String>(
                  columnName: OrderTableHeader.address, value: e.address),
              DataGridCell<String>(
                  columnName: OrderTableHeader.user, value: e.user),
              DataGridCell<String>(
                  columnName: OrderTableHeader.dispatchedBy,
                  value: e.dispatchedBy ?? ""),
              DataGridCell<String>(
                  columnName: OrderTableHeader.dateDispatched,
                  value: e.dateDispatched != null
                      ? DateFormat("MM/dd/yyyy HH:MM").format(e.dateDispatched!)
                      : ""),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _ordersContext
        .read<OrdersBloc>()
        .add(FetchCompletedOrders(startDate, endDate));
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: dataGridCell.columnName == OrderTableHeader.id
            ? Alignment.centerRight
            : dataGridCell.columnName == OrderTableHeader.attachments
                ? Alignment.center
                : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: dataGridCell.value.runtimeType != IconButton
            ? Text(dataGridCell.value.toString())
            : dataGridCell.value,
      );
    }).toList());
  }
}
