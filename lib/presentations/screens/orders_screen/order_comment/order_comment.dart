import 'package:delicious_windows_app/data/models/models.dart';
import 'package:delicious_windows_app/presentations/screens/orders_screen/order_comment_bloc/order_comment_bloc.dart';
import 'package:delicious_windows_app/presentations/screens/orders_screen/order_comment_bloc/order_comment_state.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderCommenView extends StatefulWidget {
  const OrderCommenView({
    Key? key,
    required this.orderCommentBloc,
    required this.orderId,
  }) : super(key: key);
  final OrderCommentBloc orderCommentBloc;
  final int orderId;

  @override
  State<OrderCommenView> createState() => _OrderCommenViewState();
}

class _OrderCommenViewState extends State<OrderCommenView> {
  late DataGridController _dataGridController;

  late Map<String, double> columnWidths = {
    "lineCount": double.nan,
    "comments": double.nan,
    "commented_by": double.nan,
    "comment_date": double.nan,
  };

  List<GridColumn> columnNames() {
    return [
      GridColumn(
        width: columnWidths['lineCount']!,
        columnName: 'lineCount',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            "#",
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths['comments']!,
        columnName: 'comments',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            "Comments",
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths['commented_by']!,
        columnName: 'commented_by',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            "Commented By",
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: columnWidths['comment_date']!,
        columnName: 'comment_date',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: const Text(
            "Comment Date",
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
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
    return BlocProvider.value(
      value: widget.orderCommentBloc,
      child: Mica(
        child: ScaffoldPage(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Order ID: ${widget.orderId}",
              style: FluentTheme.of(context).typography.title,
            ),
          ),
          content: Builder(
            builder: (context) =>
                BlocBuilder<OrderCommentBloc, OrderCommentState>(
              builder: (_, state) {
                OrderCommentDataSource _dataSource =
                    OrderCommentDataSource(state.orderComments);
                return SfDataGrid(
                  source: _dataSource,
                  columns: columnNames(),
                  allowSorting: true,
                  allowMultiColumnSorting: true,
                  selectionMode: SelectionMode.single,
                  navigationMode: GridNavigationMode.cell,
                  allowColumnsResizing: true,
                  columnWidthMode: ColumnWidthMode.fill,
                  onQueryRowHeight: (details) {
                    return details.getIntrinsicRowHeight(details.rowIndex);
                  },
                  onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                    setState(() {
                      columnWidths[details.column.columnName] = details.width;
                    });
                    return true;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class OrderCommentDataSource extends DataGridSource {
  OrderCommentDataSource(this._orderComments) {
    dataGridRows = _orderComments.asMap().entries.map<DataGridRow>((e) {
      int index = e.key;
      CommentModel val = e.value;
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: "lineCount",
            value: (index + 1).toString(),
          ),
          DataGridCell<String>(
            columnName: "comments",
            value: val.comment,
          ),
          DataGridCell<String>(
            columnName: "commented_by",
            value: val.createdBy,
          ),
          DataGridCell<String>(
            columnName: "comment_date",
            value: DateFormat("MM/DD/yyyy").format(val.dateCreated),
          ),
        ],
      );
    }).toList();
  }

  final List<CommentModel> _orderComments;

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: dataGridCell.columnName == 'lineCount' ||
                dataGridCell.columnName == 'comment_date'
            ? Alignment.center
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
