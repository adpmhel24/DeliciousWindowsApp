import 'package:delicious_inventory_system/data/models/customer/customer_address_model.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../widgets/custom_dialog.dart';
import 'bloc/create_customer_bloc.dart';

class NewCustomerAddressTable extends StatefulWidget {
  const NewCustomerAddressTable({Key? key}) : super(key: key);

  @override
  State<NewCustomerAddressTable> createState() =>
      _NewCustomerAddressTableState();
}

class _NewCustomerAddressTableState extends State<NewCustomerAddressTable> {
  Map<String, double> columnWidths = {
    'lineCount': 65,
    'cityMunicipality': double.nan,
    'brgy': double.nan,
    'streetAddress': double.nan,
    'otherDetails': double.nan,
    'deliveryFee': double.nan,
  };

  List<GridColumn> get columns => [
        GridColumn(
          width: columnWidths['lineCount']!,
          columnName: 'lineCount',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              '#',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths['cityMunicipality']!,
          columnName: 'cityMunicipality',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'City Municipality',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths['brgy']!,
          columnName: 'brgy',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Barangay',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths['streetAddress']!,
          columnName: 'streetAddress',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Street Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths['otherDetails']!,
          columnName: 'otherDetails',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Other Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridColumn(
          width: columnWidths['deliveryFee']!,
          columnName: 'deliveryFee',
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Delivery Fee',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<CreateCustomerBloc, CreateCustomerState>(
        builder: (_, state) {
          DataSource dataSource = DataSource(context, state.addresses);
          return SfDataGrid(
            source: dataSource,
            columns: columns,
            allowSorting: true,
            allowMultiColumnSorting: true,
            selectionMode: SelectionMode.single,
            navigationMode: GridNavigationMode.cell,
            allowColumnsResizing: true,
            isScrollbarAlwaysShown: true,
            columnWidthMode: ColumnWidthMode.fill,
            onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
              setState(() {
                columnWidths[details.column.columnName] = details.width;
              });
              return true;
            },
            allowSwiping: true,
            onSwipeStart: (details) {
              if (details.swipeDirection ==
                  DataGridRowSwipeDirection.startToEnd) {
                details.setSwipeMaxOffset(100);
              } else if (details.swipeDirection ==
                  DataGridRowSwipeDirection.endToStart) {
                details.setSwipeMaxOffset(0);
              }
              return true;
            },
            startSwipeActionsBuilder:
                (BuildContext context, DataGridRow row, int rowIndex) {
              return GestureDetector(
                onTap: () {
                  CustomDialog.warning(
                    context,
                    message: "Are you sure you want to delete?",
                    actions: [
                      Button(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Button(
                        child: const Text('OK'),
                        onPressed: () {
                          context
                              .read<CreateCustomerBloc>()
                              .add(RemoveAddressByIndex(rowIndex));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
                child: Container(
                  color: Colors.red.normal,
                  child: const Center(
                    child: Icon(FluentIcons.delete),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DataSource extends DataGridSource {
  List<CustomerAddressModel> address;
  List<DataGridRow> dataGridRows = [];
  BuildContext context;

  DataSource(
    this.context,
    this.address,
  ) {
    dataGridRows = address.asMap().entries.map<DataGridRow>((dataGridRow) {
      int indx = dataGridRow.key + 1;
      CustomerAddressModel value = dataGridRow.value;
      return DataGridRow(
        cells: [
          DataGridCell(
            columnName: 'lineCount',
            value: indx,
          ),
          DataGridCell(
            columnName: 'cityMunicipality',
            value: value.cityMunicipality ?? "",
          ),
          DataGridCell(
            columnName: 'brgy',
            value: value.brgy ?? "",
          ),
          DataGridCell(
            columnName: 'streetAddress',
            value: value.streetAddress ?? "",
          ),
          DataGridCell(
            columnName: 'otherDetails',
            value: value.otherDetails ?? "",
          ),
          DataGridCell(
            columnName: 'deliveryFee',
            value: value.deliveryFee ?? "",
          ),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

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
            width: dataGridCell.columnName == 'lineCount' ? 50 : null,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10.0),
            child: Text(dataGridCell.value.toString()),
          ),
        );
      },
    ).toList());
  }
}
