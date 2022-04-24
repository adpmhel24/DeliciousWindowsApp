import 'package:delicious_inventory_system/data/models/models.dart';
import 'package:delicious_inventory_system/data/repositories/repositories.dart';
import 'package:delicious_inventory_system/presentations/utils/constant.dart';
import 'package:delicious_inventory_system/presentations/widgets/custom_dialog.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:formz/formz.dart';

import '../../../../widgets/custom_large_dialog.dart';
import 'new_address_table.dart';
import 'bloc/create_customer_bloc.dart';
import 'new_address_form.dart';

class CreateCustomerForm extends StatefulWidget {
  const CreateCustomerForm({Key? key, required this.refreshCustomer})
      : super(key: key);

  final void Function() refreshCustomer;

  @override
  State<CreateCustomerForm> createState() => _CreateCustomerFormState();
}

class _CreateCustomerFormState extends State<CreateCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _customerCodeController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _salesDiscController =
      TextEditingController(text: '0');
  final TextEditingController _pickupDiscountController =
      TextEditingController(text: '0');
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final CustomerTypesRepo _custTypeRepo = AppRepo.customerTypeRepository;
  CustomerTypeModel? _selectedCustType;

  bool _passwordIsHidden = true;
  bool _confirmPassIsHidden = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _customerCodeController.dispose();
    _contactNumberController.dispose();
    _emailAddressController.dispose();
    _salesDiscController.dispose();
    _pickupDiscountController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void updateCustomerCode() {
    setState(() {
      _customerCodeController.text =
          "${_selectedCustType?.code[0] ?? ''}_${_firstNameController.text}${_lastNameController.text}";
    });
  }

  void clearPartnerFields() {
    _salesDiscController.clear();
    _pickupDiscountController.clear();
    _usernameController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateCustomerBloc(),
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: LayoutBuilder(builder: (_, constraint) {
              CreateCustomerBloc _bloc = context.read<CreateCustomerBloc>();
              return BlocListener<CreateCustomerBloc, CreateCustomerState>(
                listener: (_, state) {
                  if (state.status.isSubmissionInProgress) {
                    CustomDialog.loading(context);
                  } else if (state.status.isSubmissionFailure) {
                    CustomDialog.error(context, message: state.message);
                  } else if (state.status.isSubmissionSuccess) {
                    CustomDialog.success(context,
                        message: state.message,
                        actions: [
                          Button(
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.of(context)
                                  ..pop()
                                  ..pop();
                                widget.refreshCustomer();
                              })
                        ]);
                  }
                },
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Create Customer Form",
                        style: FluentTheme.of(context).typography.title,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 250,
                        child: Combobox<Object>(
                          isExpanded: true,
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
                            _bloc.add(
                              CustsTypeChanged(_selectedCustType!),
                            );
                            updateCustomerCode();
                            _bloc.add(
                              CustomerCodeChanged(_customerCodeController),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      firstRow(_bloc),
                      Constant.columnSpacer,
                      secondRow(_bloc),
                      Constant.columnSpacer,
                      thirdRow(_bloc),
                      Constant.columnSpacer,
                      Align(
                        alignment: Alignment.centerRight,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Button(
                            child: const Text("Add Address"),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return LargeDialog(
                                    constraints: const BoxConstraints(
                                        maxWidth: 500, maxHeight: 500),
                                    child: NewAddressForm(
                                      bloc: _bloc,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Constant.columnSpacer,
                      SizedBox(
                        height: 200,
                        child: CustomCard(
                          borderRadius: 5.0,
                          elevation: 0.0,
                          child: const NewCustomerAddressTable(),
                        ),
                      ),
                      Constant.columnSpacer,
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Button(
                          child: const Text("Add New Customer"),
                          onPressed: () {
                            CustomDialog.warning(
                              context,
                              message: "Are you sure you want to submit?",
                              actions: [
                                Button(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Button(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    _bloc.add(NewCustomerSubmitted());
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Row firstRow(CreateCustomerBloc _bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: TextFormBox(
            header: "First Name*",
            controller: _firstNameController,
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _firstNameController.value = TextEditingValue(
                  text: value[0].toUpperCase() + value.substring(1),
                  selection: TextSelection.collapsed(offset: value.length),
                );
              }
              _bloc.add(FirstNameChanged(_firstNameController));
              updateCustomerCode();
              _bloc.add(
                CustomerCodeChanged(_customerCodeController),
              );
            },
            validator: (_) {
              return _bloc.state.firstName.invalid ? "Required field." : null;
            },
          ),
        ),
        Constant.rowSpacer,
        Flexible(
          child: TextFormBox(
            header: "Last Name*",
            controller: _lastNameController,
            autovalidateMode: AutovalidateMode.always,
            onChanged: (value) {
              if (value.isNotEmpty) {
                _lastNameController.value = TextEditingValue(
                  text: value[0].toUpperCase() + value.substring(1),
                  selection: TextSelection.collapsed(offset: value.length),
                );
              }
              _bloc.add(
                LastNameChanged(_lastNameController),
              );
              updateCustomerCode();
              _bloc.add(
                CustomerCodeChanged(_customerCodeController),
              );
            },
            validator: (_) {
              return _bloc.state.lastName.invalid ? "Required field." : null;
            },
          ),
        ),
        Constant.rowSpacer,
        Flexible(
          child: TextFormBox(
            header: "Customer Code*",
            controller: _customerCodeController,
            autovalidateMode: AutovalidateMode.always,
            onChanged: (_) => _bloc.add(
              CustomerCodeChanged(_customerCodeController),
            ),
            validator: (_) {
              return _bloc.state.custCode.invalid ? "Required field." : null;
            },
          ),
        ),
      ],
    );
  }

  Row secondRow(CreateCustomerBloc _bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: TextFormBox(
            header: "Contact No.",
            controller: _contactNumberController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            onChanged: (value) => _bloc.add(
              ContactNumberChanged(_contactNumberController),
            ),
          ),
        ),
        Constant.rowSpacer,
        Flexible(
          flex: 2,
          child: TextFormBox(
            header: "Email Address",
            controller: _emailAddressController,
            autovalidateMode: AutovalidateMode.always,
            onChanged: (_) {
              _bloc.add(
                EmailChanged(_emailAddressController),
              );
            },
            validator: (value) {
              if (value!.isNotEmpty) {
                return _bloc.state.emailAddress.invalid
                    ? "Invalid email address."
                    : null;
              }
              return null;
            },
          ),
        ),
        Constant.rowSpacer,
        Flexible(
          child: TextFormBox(
            header: "Sales Discount %",
            enabled: _selectedCustType?.code.toLowerCase() == 'partner',
            controller: _salesDiscController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
            ],
            autovalidateMode: AutovalidateMode.always,
            onChanged: (_) => _bloc.add(
              CustomerSalesDiscountChanged(_salesDiscController),
            ),
            validator: (value) {
              if (value!.isNotEmpty) {
                return _bloc.state.salesDiscount.invalid
                    ? "Invalid discount percent."
                    : null;
              }
              return null;
            },
          ),
        ),
        Constant.rowSpacer,
        Flexible(
          child: TextFormBox(
            header: "Pickup Discount %",
            enabled: _selectedCustType?.code.toLowerCase() == 'partner',
            controller: _pickupDiscountController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
            ],
            autovalidateMode: AutovalidateMode.always,
            onChanged: (_) => _bloc.add(
              CustomerPickupDiscountChanged(_pickupDiscountController),
            ),
            validator: (value) {
              if (value!.isNotEmpty) {
                return _bloc.state.pickupDiscount.invalid
                    ? "Invalid discount percent."
                    : null;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Row thirdRow(CreateCustomerBloc _bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: TextFormBox(
            header: "Username",
            enabled: _selectedCustType?.code.toLowerCase() == 'partner',
            controller: _usernameController,
            autovalidateMode: AutovalidateMode.always,
            onChanged: (_) => _bloc.add(
              UsernameChanged(_usernameController),
            ),
            validator: (value) {
              if (_passwordController.text.isNotEmpty ||
                  _confirmPasswordController.text.isNotEmpty) {
                return _bloc.state.username.invalid
                    ? "Username is invalid."
                    : null;
              }
              return null;
            },
          ),
        ),
        Constant.rowSpacer,
        Flexible(
          child: TextFormBox(
            header: "Password",
            enabled: _selectedCustType?.code.toLowerCase() == 'partner',
            controller: _passwordController,
            obscureText: _passwordIsHidden,
            autovalidateMode: AutovalidateMode.always,
            suffix: IconButton(
              onPressed: () =>
                  setState(() => _passwordIsHidden = !_passwordIsHidden),
              icon: Icon(
                _passwordIsHidden ? FluentIcons.hide : FluentIcons.red_eye,
              ),
            ),
            onChanged: (_) => _bloc.add(
              PasswordChanged(_passwordController),
            ),
            validator: (_) {
              if (_usernameController.text.isNotEmpty) {
                return _bloc.state.password.invalid
                    ? "Password required."
                    : null;
              }
              return null;
            },
          ),
        ),
        Constant.rowSpacer,
        Flexible(
          child: TextFormBox(
            header: "Confirm Password",
            enabled: _selectedCustType?.code.toLowerCase() == 'partner',
            controller: _confirmPasswordController,
            obscureText: _confirmPassIsHidden,
            autovalidateMode: AutovalidateMode.always,
            suffix: IconButton(
              onPressed: () =>
                  setState(() => _confirmPassIsHidden = !_confirmPassIsHidden),
              icon: Icon(
                _confirmPassIsHidden ? FluentIcons.hide : FluentIcons.red_eye,
              ),
            ),
            onChanged: (_) => _bloc.add(
              ConfirmPasswordChanged(_confirmPasswordController),
            ),
            validator: (_) {
              if (_usernameController.text.isNotEmpty ||
                  _passwordController.text.isNotEmpty) {
                return _bloc.state.confirmPassword.invalid
                    ? "Password does not match."
                    : null;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
