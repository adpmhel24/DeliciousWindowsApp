import 'package:delicious_inventory_system/data/models/models.dart';
import 'package:delicious_inventory_system/data/repositories/repositories.dart';
import 'package:delicious_inventory_system/global_bloc/customers_bloc/bloc.dart';
import 'package:delicious_inventory_system/presentations/utils/constant.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../widgets/custom_large_dialog.dart';
import '../../new_customer_form_screen/create_customer_form.dart';
import 'customers_table.dart';

class CustomersBody extends StatefulWidget {
  const CustomersBody({Key? key}) : super(key: key);

  @override
  State<CustomersBody> createState() => _CustomersBodyState();
}

class _CustomersBodyState extends State<CustomersBody> {
  CustomerTypeModel? _selectedCustType;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<SfDataGridState> gridKey = GlobalKey<SfDataGridState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomerTypesRepo _custTypeRepo = AppRepo.customerTypeRepository;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Customers",
          style: FluentTheme.of(context).typography.title,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          width: 250,
          child: Combobox<Object>(
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
                      _selectedCustType = _custTypeRepo.customerTypes
                          .firstWhere((e) => e.id == -1);
                    });
                    context.read<CustomersBloc>().add(
                          FilterCustomer(
                            _searchController.text,
                            _selectedCustType?.id == -1
                                ? null
                                : _selectedCustType?.id,
                          ),
                        );
                  },
                ),
              ],
            ),
            placeholder: const Text('Select Customer Type'),
            items: _custTypeRepo.customerTypes
                .map(
                  (e) => ComboboxItem(
                    child: Text(e.code),
                    value: e,
                  ),
                )
                .toList(),
            value: _selectedCustType,
            onChanged: (value) {
              setState(() {
                _selectedCustType = value as CustomerTypeModel?;
              });
              context.read<CustomersBloc>().add(
                    FilterCustomer(
                      _searchController.text,
                      _selectedCustType?.id == -1
                          ? null
                          : _selectedCustType?.id,
                    ),
                  );
            },
          ),
        ),
        Constant.columnSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 250,
              child: TextBox(
                placeholder: "Search",
                controller: _searchController,
                onChanged: (value) {
                  context.read<CustomersBloc>().add(
                        FilterCustomer(
                          value,
                          _selectedCustType?.id == -1
                              ? null
                              : _selectedCustType?.id,
                        ),
                      );
                },
              ),
            ),
            Button(
                child: const Text("Create New Customer"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return LargeDialog(
                          child: CreateCustomerForm(
                            refreshCustomer: () {
                              gridKey.currentState!.refresh(false);
                            },
                          ),
                        );
                      });
                }),
          ],
        ),
        Constant.columnSpacer,
        IconButton(
            icon: const Icon(FluentIcons.refresh),
            onPressed: () {
              setState(() {
                _selectedCustType =
                    _custTypeRepo.customerTypes.firstWhere((e) => e.id == -1);
              });
              context.read<CustomersBloc>().add(
                    FilterCustomer(
                      _searchController.text,
                      _selectedCustType?.id == -1
                          ? null
                          : _selectedCustType?.id,
                    ),
                  );
              gridKey.currentState!.refresh(false);
            }),
        Constant.columnSpacer,
        Expanded(
          child: CustomCard(
            borderRadius: 5.0,
            elevation: 0,
            child: CustomerTables(gridKey: gridKey),
          ),
        ),
      ],
    );
  }
}
