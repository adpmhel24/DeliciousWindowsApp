import 'package:delicious_windows_app/data/models/models.dart';
import 'package:delicious_windows_app/data/models/orders/order_model.dart';
import 'package:delicious_windows_app/data/repositories/repositories.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../utils/currency_formater.dart';
import '../../../../widgets/info_label_row.dart';
import 'order_rows.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final TextEditingController _dispWhseController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _paymentRefController = TextEditingController();
  final TextEditingController _paidAmount = TextEditingController();

  String? _discTypeSelected;
  String? _salesTypeSelected;

  final DiscountTypeRepo _discountTypeRepo = AppRepo.discTypeRepository;
  final SalesTypeRepo _salesTypesRepo = AppRepo.salesTypeRepository;
  List<DiscTypeModel> _discountTypes = [];
  List<SalesTypeModel> _salesTypes = [];

  @override
  void initState() {
    _discountTypes = _discountTypeRepo.discTypes;
    _salesTypes = _salesTypesRepo.salesType;
    super.initState();
  }

  @override
  void dispose() {
    _dispWhseController.dispose();
    _remarksController.dispose();
    _paymentRefController.dispose();
    _paidAmount.dispose();
    super.dispose();
  }

  final List<String> _dispatchingWhse = const ["1", "2", "3"];

  String? wew;
  String? comboBoxValue;

  @override
  Widget build(BuildContext context) {
    return Mica(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoLabelRow(
                          label: "Order Id:",
                          child: Text(
                            widget.order.id.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InfoLabelRow(
                          label: "Transaction Date:",
                          child: Text(
                            DateFormat("MM/dd/yyyy").format(
                                widget.order.transdate ?? DateTime.now()),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InfoLabelRow(
                          label: "Delivery Date:",
                          child: Text(
                            DateFormat("MM/dd/yyyy").format(
                                widget.order.deliveryDate ?? DateTime.now()),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InfoLabelRow(
                          label: "Customer Code:",
                          child: Text(
                            widget.order.custCode ?? "",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InfoLabelRow(
                          label: "Dispatching Whse:",
                          child: Combobox<String>(
                            placeholder: const Text('Select Warehouse'),
                            // isExpanded: true,
                            items: _dispatchingWhse
                                .map(
                                  (e) => ComboboxItem(
                                    child: Text(e),
                                    value: e,
                                  ),
                                )
                                .toList(),
                            value: _dispWhseController.text.isEmpty
                                ? null
                                : _dispWhseController.text,
                            onChanged: (value) {
                              if (value != null) {
                                setState(
                                    () => _dispWhseController.text = value);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InfoLabelRow(
                          label: "Discount Type:",
                          child: Combobox<String>(
                            placeholder: const Text('Select Discount Type'),
                            // isExpanded: true,
                            items: _discountTypes
                                .map(
                                  (e) => ComboboxItem(
                                    child: Text(e.description),
                                    value: e.description,
                                  ),
                                )
                                .toList(),
                            value: _discTypeSelected,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _discTypeSelected = value);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InfoLabelRow(
                          label: "Sales Type:",
                          child: Combobox<String>(
                            placeholder: const Text('Select Sales Type'),
                            // isExpanded: true,
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
                                setState(() => _salesTypeSelected = value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            OrderRowsTable(
              orderRows: widget.order.rows,
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
                          controller: _remarksController,
                          minLines: 3,
                          maxLines: 5,
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
                                widget.order.subtotal.toString(),
                                hasCurrency: true),
                          ),
                        ),
                        InfoLabelRow(
                          label: "Delivery Fee:",
                          child: Text(
                            formatStringToDecimal(
                              widget.order.delfee.toString(),
                              hasCurrency: true,
                            ),
                          ),
                        ),
                        InfoLabelRow(
                          label: "Other Fee:",
                          child: Text(
                            formatStringToDecimal(
                              widget.order.otherfee.toString(),
                              hasCurrency: true,
                            ),
                          ),
                        ),
                        InfoLabelRow(
                          label: "Doctotal",
                          child: Text(
                            formatStringToDecimal(
                              widget.order.doctotal.toString(),
                              hasCurrency: true,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
