import 'package:delicious_windows_app/data/models/models.dart';

import 'package:delicious_windows_app/data/repositories/repositories.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/orders/order_model.dart';
import '../../../../utils/currency_formater.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/info_label_row.dart';
import '../order_bloc/bloc.dart';
import 'order_rows_read_only.dart';

class OrderDetailsReadOnly extends StatefulWidget {
  const OrderDetailsReadOnly({
    Key? key,
    required this.orderModel,
    required this.refreshOrders,
    required this.orderBloc,
    required this.view,
  }) : super(key: key);
  final OrderModel orderModel;
  final Function refreshOrders;
  final OrderBloc orderBloc;
  final String view;

  @override
  State<OrderDetailsReadOnly> createState() => _OrderDetailsReadOnlyState();
}

class _OrderDetailsReadOnlyState extends State<OrderDetailsReadOnly> {
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _paymentRefController = TextEditingController();
  final TextEditingController _paidAmount = TextEditingController();

  final DiscountTypeRepo _discountTypeRepo = AppRepo.discTypeRepository;
  final SalesTypeRepo _salesTypesRepo = AppRepo.salesTypeRepository;
  final WarehouseRepo _warehouseRepo = AppRepo.whseRepository;
  List<WarehouseModel> _warehouses = [];
  List<DiscTypeModel> _discountTypes = [];
  List<SalesTypeModel> _salesTypes = [];

  // holds the choices of orderStatus

  @override
  void initState() {
    _remarksController.text = widget.orderModel.remarks ?? '';

    _paidAmount.text = (widget.orderModel.paidAmount ?? 0).toStringAsFixed(2);
    _warehouses = _warehouseRepo.whses;
    _discountTypes = _discountTypeRepo.discTypes;
    _salesTypes = _salesTypesRepo.salesType;

    super.initState();
  }

  @override
  void dispose() {
    _remarksController.dispose();
    _paymentRefController.dispose();
    _paidAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.orderBloc,
      child: Mica(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerLeft(),
                    headerRight(),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              OrderRowTablReadOnly(
                rows: widget.orderModel.rows,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: 350,
                        child: InfoLabelRow(
                          label: "Remarks: ",
                          crossAxisAlignment: CrossAxisAlignment.start,
                          child: TextFormBox(
                            enabled: widget.view == 'dispatched',
                            controller: _remarksController,
                            minLines: 3,
                            maxLines: 5,
                            onChanged: (_) {
                              widget.orderModel.remarks =
                                  _remarksController.text;
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 300,
                        child: Column(children: [
                          InfoLabelRow(
                            label: "Subtotal:",
                            child: Text(
                              formatStringToDecimal(
                                  widget.orderModel.subtotal.toString(),
                                  hasCurrency: true),
                            ),
                          ),
                          InfoLabelRow(
                            label: "Delivery Fee:",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderModel.delfee.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ),
                          InfoLabelRow(
                            label: "Other Fee:",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderModel.otherfee.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ),
                          InfoLabelRow(
                            label: "Doctotal",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderModel.doctotal.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ),
                          InfoLabelRow(
                            label: "Balance",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderModel.balance.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: (widget.view == 'dispatched')
                        ? [
                            material.ElevatedButton(
                                style: material.ButtonStyle(
                                  backgroundColor:
                                      material.MaterialStateProperty.all<Color>(
                                          Colors.red.lighter),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Close'),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            SizedBox(
                              width: 20.w,
                            ),
                            Builder(
                              builder: (context) {
                                return BlocListener<OrderBloc, OrderState>(
                                  listenWhen: (previous, current) =>
                                      current is CreatingSalesError ||
                                      current is SalesSubmitting ||
                                      current is SalesCreated,
                                  listener: (_, state) {
                                    if (state is SalesSubmitting) {
                                      CustomDialog.loading(context);
                                    } else if (state is SalesCreated) {
                                      CustomDialog.success(context,
                                          message: state.message,
                                          actions: [
                                            Button(
                                                child: const Text('Okay'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                    ..pop()
                                                    ..pop();
                                                  // Fetch Order
                                                  widget.refreshOrders();
                                                }),
                                          ]);
                                    } else if (state is CreatingSalesError) {
                                      CustomDialog.error(context,
                                          message: state.message);
                                    }
                                  },
                                  child: material.ElevatedButton(
                                      style: material.ButtonStyle(
                                        backgroundColor:
                                            material.MaterialStateProperty.all<
                                                Color>(Colors.blue.lighter),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('Dispatch'),
                                      ),
                                      onPressed: () {
                                        CustomDialog.warning(context,
                                            message:
                                                "Are you sure you want to submit?",
                                            actions: [
                                              Button(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                              Button(
                                                  child: const Text('Proceed'),
                                                  onPressed: () {
                                                    widget.orderBloc.add(
                                                        SubmitCreateSales(
                                                            widget.orderModel
                                                                .toJsonSales(),
                                                            widget.orderModel
                                                                .paidAmount));
                                                    Navigator.of(context).pop();
                                                  }),
                                            ]);
                                      }),
                                );
                              },
                            ),
                          ]
                        : [
                            material.ElevatedButton(
                                style: material.ButtonStyle(
                                  backgroundColor: material
                                      .MaterialStateProperty.resolveWith(
                                    (Set states) {
                                      if (states.contains(
                                          material.MaterialState.pressed)) {
                                        return material.Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.5);
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Close'),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Flexible headerRight() {
    return Flexible(
      child: SizedBox(
        width: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoLabelRow(
              label: "Dispatching Whse:",
              child: Text(_warehouses
                  .firstWhere(
                      (e) => e.whsecode == widget.orderModel.dispatchingWhse)
                  .whsename),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Discount Type:",
              child: Text(widget.orderModel.disctype == null
                  ? ""
                  : _discountTypes
                      .firstWhere((e) => e.code == widget.orderModel.disctype)
                      .description),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Sales Type:",
              child: Text(widget.orderModel.salestype == null
                  ? ""
                  : _salesTypes
                      .firstWhere((e) => e.code == widget.orderModel.salestype)
                      .description),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Order Status:",
              child: Text(widget.orderModel.orderStatus ?? ""),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Payment Amount:",
              child: TextBox(
                enabled: widget.view == 'dispatched',
                controller: _paidAmount,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                ],
                onChanged: (value) {
                  double paidAmnt = double.tryParse(value) ?? 0;
                  widget.orderModel.paidAmount =
                      double.parse(paidAmnt.toStringAsFixed(2));
                  setState(() {
                    widget.orderModel.balance = widget.orderModel.doctotal! -
                        double.parse(paidAmnt.toStringAsFixed(2));
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Flexible headerLeft() {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabelRow(
            label: "Order Id:",
            child: Text(
              widget.orderModel.id.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InfoLabelRow(
            label: "Transaction Date:",
            child: Text(
              DateFormat("MM/dd/yyyy")
                  .format(widget.orderModel.transdate ?? DateTime.now()),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InfoLabelRow(
            label: "Delivery Date:",
            child: Text(
              DateFormat("MM/dd/yyyy")
                  .format(widget.orderModel.deliveryDate ?? DateTime.now()),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InfoLabelRow(
            label: "Customer Code:",
            child: Text(
              widget.orderModel.custCode ?? "",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InfoLabelRow(
            label: "Delivery Address:",
            child: Text(
              widget.orderModel.address ?? "",
            ),
          ),
        ],
      ),
    );
  }
}
