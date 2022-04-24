import 'package:delicious_inventory_system/data/models/models.dart';
import 'package:delicious_inventory_system/global_bloc/bloc.dart';
import 'package:delicious_inventory_system/presentations/widgets/custom_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../widgets/custom_large_dialog.dart';
import '../../customer_info_view/customer_details_view.dart';

class CustomerTables extends StatefulWidget {
  const CustomerTables({Key? key, required this.gridKey}) : super(key: key);
  final GlobalKey<SfDataGridState> gridKey;

  @override
  State<CustomerTables> createState() => _CustomerTablesState();
}

class _CustomerTablesState extends State<CustomerTables> {
  late DataSource _dataSource;

  final int _rowsPerPage = 15;

  final double _dataPagerHeight = 60.0;

  final List<CustomerModel> _paginatedCustomers = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomersBloc, CustomersState>(
      listener: (_, state) {
        if (state.status == CustomersStateStatus.error) {
          CustomDialog.error(context, message: state.message);
        }
      },
      builder: (_, state) {
        if (state.status == CustomersStateStatus.success) {
          _dataSource = DataSource(
            context,
            state.customers,
            _paginatedCustomers,
            _rowsPerPage,
          );
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: constraint.maxHeight - _dataPagerHeight,
                  width: constraint.maxWidth,
                  child: SfDataGrid(
                    key: widget.gridKey,
                    source: _dataSource,
                    allowSorting: true,
                    allowMultiColumnSorting: true,
                    selectionMode: SelectionMode.single,
                    navigationMode: GridNavigationMode.cell,
                    allowColumnsResizing: true,
                    isScrollbarAlwaysShown: true,
                    allowPullToRefresh: true,
                    columns: CustomerTable.columns,
                    columnWidthMode: constraint.maxWidth < 900
                        ? ColumnWidthMode.auto
                        : ColumnWidthMode.fill,
                    onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                      setState(() {
                        CustomerTable.columnWidths[details.column.columnName] =
                            details.width;
                      });
                      return true;
                    },
                    onCellDoubleTap: (
                      details,
                    ) async {
                      if (details.rowColumnIndex.rowIndex > 0) {
                        CustomerModel customerModel =
                            _dataSource.paginatedCustomers[
                                details.rowColumnIndex.rowIndex - 1];

                        showDialog(
                          context: context,
                          builder: (_) {
                            return LargeDialog(
                              child: CustomerInfoView(
                                customerId: customerModel.id!,
                                customerBloc: context.read<CustomersBloc>(),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: _dataPagerHeight,
                  child: SfDataPager(
                    delegate: _dataSource,
                    pageCount: (state.customers.length / _rowsPerPage) +
                        ((state.customers.length % _rowsPerPage) > 0 ? 1 : 0),
                    direction: Axis.horizontal,
                  ),
                ),
              ],
            );
          });
        }
        return const SizedBox.expand(
          child: Center(
            child: ProgressRing(),
          ),
        );
      },
    );
  }
}

class DataSource extends DataGridSource {
  final int _rowsPerPage;
  List<CustomerModel> customers;
  List<CustomerModel> paginatedCustomers;
  List<DataGridRow> dataGridRows = [];
  int startIndex = 0;
  int endIndex = 15;
  BuildContext context;
  @override
  List<DataGridRow> get rows => dataGridRows;

  DataSource(
    this.context,
    this.customers,
    this.paginatedCustomers,
    this._rowsPerPage,
  ) {
    if (customers.length < endIndex) {
      endIndex = customers.length;
    }
    paginatedCustomers =
        customers.getRange(startIndex, endIndex).toList(growable: false);
    buildPaginatedDataGridRows();
  }

  void buildPaginatedDataGridRows() {
    dataGridRows =
        paginatedCustomers.asMap().entries.map<DataGridRow>((dataGridRow) {
      int indx = dataGridRow.key + 1 + startIndex;
      CustomerModel value = dataGridRow.value;
      return DataGridRow(
        cells: [
          DataGridCell(
            columnName: CustomerTable.lineCount,
            value: indx,
          ),
          DataGridCell(
            columnName: CustomerTable.custCode,
            value: value.code ?? "",
          ),
          DataGridCell(
            columnName: CustomerTable.custName,
            value: value.name ?? "",
          ),
          DataGridCell(
            columnName: CustomerTable.custType,
            value: value.custTypeName ?? "",
          ),
          DataGridCell(
            columnName: CustomerTable.firstName,
            value: value.firstName ?? "",
          ),
          DataGridCell(
            columnName: CustomerTable.lastName,
            value: value.lastName ?? "",
          ),
          DataGridCell(
            columnName: CustomerTable.contactNumber,
            value: value.contactNumber ?? "",
          ),
          DataGridCell(
            columnName: CustomerTable.email,
            value: value.email ?? "",
          ),
          DataGridCell(
            columnName: CustomerTable.salesDisc,
            value: "${value.allowedDisc ?? 0}%",
          ),
          DataGridCell(
            columnName: CustomerTable.pickupDisc,
            value: "${value.pickupDisc ?? 0}%",
          ),
          DataGridCell(
            columnName: CustomerTable.user,
            value: value.user != null ? value.user!['username'] : '',
          ),
        ],
      );
    }).toList(growable: false);
  }

  @override
  Future<void> handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 200));
    context.read<CustomersBloc>().add(
          FetchCustomerFromAPI(),
        );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    startIndex = newPageIndex * _rowsPerPage;
    endIndex = startIndex + _rowsPerPage;
    if (startIndex < customers.length && endIndex <= customers.length) {
      paginatedCustomers =
          customers.getRange(startIndex, endIndex).toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else if (startIndex < customers.length && endIndex > customers.length) {
      paginatedCustomers = customers
          .getRange(startIndex, customers.length)
          .toList(growable: false);
      buildPaginatedDataGridRows();
      notifyListeners();
    } else {
      paginatedCustomers = [];
    }

    return true;
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        return GestureDetector(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: dataGridCell.value)).then(
              (value) {
                showSnackbar(
                  context,
                  const Snackbar(
                    content: Text('Copied'),
                  ),
                );
              },
            );
          },
          child: Container(
            width:
                dataGridCell.columnName == CustomerTable.lineCount ? 50 : null,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10.0),
            child: Text(dataGridCell.value.toString()),
          ),
        );
      },
    ).toList());
  }
}
