import 'package:delicious_windows_app/data/models/models.dart';

import 'package:delicious_windows_app/data/repositories/repositories.dart';
import 'package:delicious_windows_app/presentations/widgets/custom_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../utils/currency_formater.dart';
import '../../../../widgets/info_label_row.dart';

import '../order_bloc/bloc.dart';
import 'order_rows.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
    required this.orderRepo,
    required this.fetchOrders,
    required this.orderBloc,
  }) : super(key: key);
  final OrderRepository orderRepo;
  final Function fetchOrders;
  final OrderBloc orderBloc;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _paymentRefController = TextEditingController();
  final TextEditingController _paidAmount = TextEditingController();

  String? _dispatchingWhseSelected;
  String? _discTypeSelected;
  String? _salesTypeSelected;
  String? _orderStatusSelected;

  final DiscountTypeRepo _discountTypeRepo = AppRepo.discTypeRepository;
  final SalesTypeRepo _salesTypesRepo = AppRepo.salesTypeRepository;
  final WarehouseRepo _warehouseRepo = AppRepo.whseRepository;
  List<WarehouseModel> _warehouses = [];
  List<DiscTypeModel> _discountTypes = [];
  List<SalesTypeModel> _salesTypes = [];

  // holds the choices of orderStatus
  late List<String> _orderStatus = [];

  @override
  void initState() {
    _dispatchingWhseSelected = widget.orderRepo.order.dispatchingWhse;
    _discTypeSelected = widget.orderRepo.order.disctype;
    _salesTypeSelected = widget.orderRepo.order.salestype;
    _remarksController.text = widget.orderRepo.order.remarks ?? '';
    _orderStatusSelected = widget.orderRepo.order.orderStatus;
    _paidAmount.text =
        (widget.orderRepo.order.paidAmount ?? 0).toStringAsFixed(2);
    _warehouses = _warehouseRepo.whses;
    _discountTypes = _discountTypeRepo.discTypes;
    _salesTypes = _salesTypesRepo.salesType;

    // Add to OrderState
    if (widget.orderRepo.order.orderStatus == "For Confirmation") {
      _orderStatus = [
        "For Confirmation",
        "Confirmed",
      ];
    } else {
      _orderStatus = ["Dispatched"];
    }

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
                    headerLeft(widget.orderRepo),
                    headerRight(true),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const OrderRowsTable(),
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
                            controller: _remarksController,
                            minLines: 3,
                            maxLines: 5,
                            onChanged: (_) {
                              widget.orderRepo.updateHeader(
                                  {"remarks": _remarksController.text});
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
                                  widget.orderRepo.order.subtotal.toString(),
                                  hasCurrency: true),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          InfoLabelRow(
                            label: "Delivery Fee:",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderRepo.order.delfee.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          InfoLabelRow(
                            label: "Other Fee:",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderRepo.order.otherfee.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          InfoLabelRow(
                            label: "Doctotal",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderRepo.order.doctotal.toString(),
                                hasCurrency: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          InfoLabelRow(
                            label: "Balance",
                            child: Text(
                              formatStringToDecimal(
                                widget.orderRepo.order.balance.toString(),
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
                    children: [
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
                                current is OrderUpdateSubmitting ||
                                current is OrderSuccessfullyUpdated ||
                                current is ErrorOrderState,
                            listener: (_, state) {
                              if (state is OrderUpdateSubmitting) {
                                CustomDialog.loading(context);
                              } else if (state is OrderSuccessfullyUpdated) {
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
                                            widget.fetchOrders();
                                          }),
                                    ]);
                              } else if (state is ErrorOrderState) {
                                CustomDialog.error(context,
                                    message: state.message);
                              }
                            },
                            child: material.ElevatedButton(
                                style: material.ButtonStyle(
                                  backgroundColor:
                                      material.MaterialStateProperty.all<Color>(
                                          Colors.blue.lighter),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Update'),
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
                                              context.read<OrderBloc>().add(
                                                  SubmitUpdateOrder(
                                                      orderId: widget
                                                          .orderRepo.order.id!,
                                                      data: widget
                                                          .orderRepo.order
                                                          .toJson(),
                                                      orderRepo:
                                                          widget.orderRepo));
                                              Navigator.of(context).pop();
                                            }),
                                      ]);
                                }),
                          );
                        },
                      ),
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

  Flexible headerRight(bool isEdittable) {
    return Flexible(
      child: SizedBox(
        width: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoLabelRow(
              label: "Dispatching Whse:",
              child: isEdittable
                  ? Combobox<String>(
                      placeholder: const Text('Select Warehouse'),
                      // isExpanded: true,
                      items: _warehouses
                          .map(
                            (e) => ComboboxItem(
                              child: Text(e.whsename),
                              value: e.whsecode,
                            ),
                          )
                          .toList(),
                      value: _dispatchingWhseSelected,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _dispatchingWhseSelected = value;
                          });
                          widget.orderRepo.updateHeader(
                              {"dispatchingWhse": _dispatchingWhseSelected});
                        }
                      },
                    )
                  : Text("$_dispatchingWhseSelected"),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Discount Type:",
              child: isEdittable
                  ? Combobox<String>(
                      icon: Row(
                        children: [
                          const Icon(FluentIcons.chevron_down),
                          const SizedBox(
                            width: 10,
                          ),
                          Button(
                            child: const Icon(FluentIcons.clear),
                            onPressed: () {
                              setState(() {
                                _discTypeSelected = null;
                              });
                              widget.orderRepo.updateHeader(
                                  {"disctype": _discTypeSelected});
                            },
                          ),
                        ],
                      ),
                      placeholder: const Text('Select Discount Type'),
                      items: _discountTypes
                          .map(
                            (e) => ComboboxItem(
                              child: Text(e.description),
                              value: e.code,
                            ),
                          )
                          .toList(),
                      value: _discTypeSelected,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _discTypeSelected = value;
                          });
                          widget.orderRepo
                              .updateHeader({"disctype": _discTypeSelected});
                        }
                      },
                    )
                  : Text(_discountTypes
                      .firstWhere((e) => e.code == _discTypeSelected)
                      .description),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Sales Type:",
              child: isEdittable
                  ? Combobox<String>(
                      placeholder: const Text('Select Sales Type'),
                      items: _salesTypes
                          .map(
                            (e) => ComboboxItem(
                              child: Text(e.description),
                              value: e.code,
                            ),
                          )
                          .toList(),
                      value: _salesTypeSelected,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _salesTypeSelected = value;
                          });
                          widget.orderRepo
                              .updateHeader({"salestype": _salesTypeSelected});
                        }
                      },
                    )
                  : Text(_salesTypes
                      .firstWhere((e) => e.code == _salesTypeSelected)
                      .description),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Order Status:",
              child: Combobox<String>(
                placeholder: const Text('Select Order Status'),
                items: _orderStatus
                    .map(
                      (e) => ComboboxItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                value: _orderStatusSelected,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _orderStatusSelected = value;
                    });
                    widget.orderRepo
                        .updateHeader({"orderStatus": _orderStatusSelected});
                  }
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InfoLabelRow(
              label: "Payment Amount:",
              child: TextBox(
                controller: _paidAmount,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                ],
                onChanged: (value) {
                  double paidAmnt = double.tryParse(value) ?? 0;
                  widget.orderRepo.updatePaidAmount(
                      double.parse(paidAmnt.toStringAsFixed(2)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Flexible headerLeft(OrderRepository orderRepo) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabelRow(
            label: "Order Id:",
            child: Text(
              orderRepo.order.id.toString(),
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
                  .format(orderRepo.order.transdate ?? DateTime.now()),
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
                  .format(orderRepo.order.deliveryDate ?? DateTime.now()),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InfoLabelRow(
            label: "Customer Code:",
            child: Text(
              orderRepo.order.custCode ?? "",
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InfoLabelRow(
            label: "Delivery Address:",
            child: Text(
              orderRepo.order.address ?? "",
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InfoLabelRow(
            label: "Payment Method:",
            child: Text(
              orderRepo.order.paymentMethod ?? "",
            ),
          ),
        ],
      ),
    );
  }
}
