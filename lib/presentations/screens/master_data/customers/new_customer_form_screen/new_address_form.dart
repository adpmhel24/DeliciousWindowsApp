import 'package:delicious_inventory_system/data/models/customer/customer_address_model.dart';
import 'package:delicious_inventory_system/presentations/utils/constant.dart';
import 'package:delicious_inventory_system/presentations/widgets/brgy_modal_content.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../global_bloc/bloc.dart';
import '../../../../widgets/city_municpality_modal_content.dart';
import '../../../../widgets/custom_large_dialog.dart';
import 'bloc/create_customer_bloc.dart';

class NewAddressForm extends StatefulWidget {
  const NewAddressForm({Key? key, required this.bloc}) : super(key: key);

  final Bloc bloc;

  @override
  State<NewAddressForm> createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final TextEditingController _cityMunicipalityController =
      TextEditingController();
  final TextEditingController _brgyController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _otherDetailsController = TextEditingController();
  final TextEditingController _deliveryFeeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String cityMunicipalityCode = '';

  @override
  void dispose() {
    _cityMunicipalityController.dispose();
    _brgyController.dispose();
    _streetAddressController.dispose();
    _otherDetailsController.dispose();
    _deliveryFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Add Address",
                style: FluentTheme.of(context).typography.title,
              ),
              Constant.columnSpacer,
              TextFormBox(
                header: "City / Municipality",
                controller: _cityMunicipalityController,
                readOnly: true,
                onTap: () {
                  context
                      .read<CityMunicipalityBloc>()
                      .add(FetchCityMunicipalityFromLocal());
                  showDialog(
                      context: context,
                      builder: (_) {
                        return LargeDialog(
                          constraints: const BoxConstraints(
                              maxWidth: 500, maxHeight: 500),
                          child: CityMunicipalityModalContent(
                            controller: _cityMunicipalityController,
                            onTap: (classModel) {
                              cityMunicipalityCode = classModel.code;
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      });
                },
              ),
              TextFormBox(
                header: "Barangay",
                controller: _brgyController,
                readOnly: true,
                onTap: () {
                  if (cityMunicipalityCode.isNotEmpty) {
                    context
                        .read<BrgyBloc>()
                        .add(FetchBrgyFromAPI(cityMunicipalityCode));
                    showDialog(
                      context: context,
                      builder: (_) {
                        return LargeDialog(
                          constraints: const BoxConstraints(
                              maxWidth: 500, maxHeight: 500),
                          child: BrgyModalContent(
                            controller: _brgyController,
                            onTap: (classModel) {
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              TextFormBox(
                header: "Street Address*",
                controller: _streetAddressController,
                minLines: 3,
                maxLines: 6,
                validator: (value) {
                  return value == null || value.isEmpty
                      ? "Required Field"
                      : null;
                },
              ),
              TextFormBox(
                header: "Other details",
                controller: _otherDetailsController,
                minLines: 2,
                maxLines: 4,
              ),
              TextFormBox(
                header: "Delivery Fee",
                controller: _deliveryFeeController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                ],
              ),
              Constant.columnSpacer,
              SizedBox(
                width: double.infinity,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Button(
                    child: const Text("Add"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          "city_municipality":
                              _cityMunicipalityController.text.isEmpty
                                  ? null
                                  : _cityMunicipalityController.text,
                          "brgy": _brgyController.text.isEmpty
                              ? null
                              : _brgyController.text,
                          "street_address": _streetAddressController.text,
                          "other_details": _otherDetailsController.text.isEmpty
                              ? null
                              : _otherDetailsController.text,
                          "delivery_fee":
                              double.tryParse(_deliveryFeeController.text),
                        };

                        CustomerAddressModel _address =
                            CustomerAddressModel.fromJson(data);
                        widget.bloc.add(AddedCustomerAddress(_address));
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(elevation: ButtonState.all(3.0)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
