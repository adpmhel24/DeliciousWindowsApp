import 'package:delicious_inventory_system/global_bloc/customers_bloc/bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:formz/formz.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repositories.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/custom_large_dialog.dart';
import 'bloc/bloc.dart';
import 'components/address_form.dart';
import 'components/customer_addresses.dart';

class CustomerInfoView extends StatelessWidget {
  const CustomerInfoView({
    Key? key,
    required this.customerId,
    required this.customerBloc,
  }) : super(key: key);

  final int customerId;
  final CustomersBloc customerBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CustomerInfoViewBloc()
            ..add(
              FetchCustomerInfo(customerId),
            ),
        ),
      ],
      child: CustomerInfoBody(
        customerBloc: customerBloc,
      ),
    );
  }
}

class CustomerInfoBody extends StatefulWidget {
  const CustomerInfoBody({
    Key? key,
    required this.customerBloc,
  }) : super(key: key);

  final CustomersBloc customerBloc;

  @override
  State<CustomerInfoBody> createState() => _CustomerInfoBodyState();
}

class _CustomerInfoBodyState extends State<CustomerInfoBody> {
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

  final CustomerTypesRepo _custTypeRepo = AppRepo.customerTypeRepository;
  final CustomerTypesRepo _customerTypeRepo = AppRepo.customerTypeRepository;
  CustomerTypeModel? _selectedCustType;
  late CustomerModel customerInfo;
  bool customerIsActive = true;

  bool _passwordIsHidden = true;
  late UpdateCustomerInfoBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

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

    super.dispose();
  }

  void updateCustomerCode(UpdateCustomerInfoBloc bloc) {
    setState(() {
      _customerCodeController.text =
          "${_selectedCustType?.code[0] ?? ''}_${_firstNameController.text}${_lastNameController.text}";
    });

    bloc.add(CustomerCodeChanged(_customerCodeController));
  }

  void clearPartnerFields() {
    _salesDiscController.clear();
    _pickupDiscountController.clear();
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdateCustomerInfoBloc>(
          lazy: false,
          create: (_) => UpdateCustomerInfoBloc(
            context.read<CustomerInfoViewBloc>(),
          ),
        ),
        BlocProvider<UpdateAddAddressBloc>(
          create: (_) => UpdateAddAddressBloc(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CustomerInfoViewBloc, CustomerInfoViewState>(
            listener: (_, state) {
              if (state.fetchingStatus == CustomerInfoViewStatus.success) {
                customerInfo = state.fetchedCustomer!;
                _firstNameController.text = customerInfo.firstName ?? '';
                _lastNameController.text = customerInfo.lastName ?? '';
                _customerCodeController.text = customerInfo.code ?? '';
                _contactNumberController.text =
                    customerInfo.contactNumber ?? '';
                _emailAddressController.text = customerInfo.email ?? '';
                _salesDiscController.text =
                    customerInfo.allowedDisc?.toStringAsFixed(2) ?? '';
                _pickupDiscountController.text =
                    customerInfo.pickupDisc?.toStringAsFixed(2) ?? '';
                _usernameController.text = customerInfo.user?['username'] ?? '';
                customerIsActive = customerInfo.isActive;
                _selectedCustType = _customerTypeRepo
                    .getCustTypeById(state.fetchedCustomer!.custType!);
              }
            },
          ),
          BlocListener<UpdateCustomerInfoBloc, UpdateCustomerInfoState>(
            listener: (_, state) {
              if (state.status.isSubmissionInProgress) {
                CustomDialog.loading(context);
              } else if (state.status.isSubmissionSuccess) {
                CustomDialog.success(context,
                    message: "Successfully added!",
                    actions: [
                      Button(
                          child: const Text("OK"),
                          onPressed: () {
                            widget.customerBloc.add(FetchCustomerFromAPI());
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          })
                    ]);
              } else if (state.status.isSubmissionFailure) {
                CustomDialog.error(context, message: state.message);
              }
            },
          ),
          BlocListener<UpdateAddAddressBloc, UpdateAddAddressState>(
            listener: (context, state) {
              if (state.status == UpdateAddAddressStateStatus.loading) {
                CustomDialog.loading(context);
              } else if (state.status ==
                      UpdateAddAddressStateStatus.updatedSuccess ||
                  state.status == UpdateAddAddressStateStatus.addedSuccess) {
                widget.customerBloc.add(FetchCustomerFromAPI());
                CustomDialog.success(
                  context,
                  message: state.message,
                  actions: [
                    Button(
                      child: const Text('OK'),
                      onPressed: () {
                        context.read<CustomerInfoViewBloc>().add(
                              FetchCustomerInfo(customerInfo.id!),
                            );
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                    ),
                  ],
                );
              } else if (state.status ==
                  UpdateAddAddressStateStatus.deletedSuccess) {
                widget.customerBloc.add(FetchCustomerFromAPI());
                CustomDialog.success(
                  context,
                  message: state.message,
                  actions: [
                    Button(
                      child: const Text('OK'),
                      onPressed: () {
                        context.read<CustomerInfoViewBloc>().add(
                              FetchCustomerInfo(customerInfo.id!),
                            );
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              } else if (state.status == UpdateAddAddressStateStatus.error) {
                CustomDialog.error(context, message: state.message);
              }
            },
          ),
        ],
        child: BlocBuilder<CustomerInfoViewBloc, CustomerInfoViewState>(
          bloc: context.read<CustomerInfoViewBloc>(),
          builder: (context, state) {
            if (state.fetchingStatus == CustomerInfoViewStatus.success) {
              _bloc = context.read<UpdateCustomerInfoBloc>();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
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
                              state.fetchedCustomer!.custType =
                                  _selectedCustType!.id;
                              setState(() {
                                _selectedCustType = value as CustomerTypeModel?;
                              });
                              _bloc.add(
                                CustsTypeChanged(_selectedCustType!),
                              );
                              updateCustomerCode(_bloc);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              checked: customerIsActive,
                              onChanged: (value) {
                                setState(() {
                                  customerIsActive = value!;
                                });
                                if (value != null) {
                                  context.read<UpdateCustomerInfoBloc>().add(
                                        CustomerActiveChanged(value),
                                      );
                                }
                              },
                              content: const Text('Active'),
                            ),
                            MouseRegion(
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
                                        child: AddressForm(
                                          customerId:
                                              state.fetchedCustomer!.id!,
                                          bloc: context
                                              .read<UpdateAddAddressBloc>(),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Constant.columnSpacer,
                        SizedBox(
                          height: 200,
                          child: CustomCard(
                            borderRadius: 5.0,
                            elevation: 0.0,
                            child: CustomerDetailAddress(
                                addresses: state.fetchedCustomer!.details!),
                          ),
                        ),
                        Constant.columnSpacer,
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Button(
                            child: const Text("Update"),
                            onPressed: context
                                        .watch<UpdateCustomerInfoBloc>()
                                        .state
                                        .status
                                        .isPure ||
                                    context
                                        .watch<UpdateCustomerInfoBloc>()
                                        .state
                                        .status
                                        .isInvalid
                                ? null
                                : () {
                                    CustomDialog.warning(
                                      context,
                                      message:
                                          "Are you sure you want to submit?",
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
                                            _bloc.add(
                                              UpdateCustomerSubmitted(
                                                state.fetchedCustomer!.id!,
                                              ),
                                            );
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
                ),
              );
            } else {
              return const Center(
                child: ProgressRing(),
              );
            }
          },
        ),
      ),
    );
  }

  Row firstRow(UpdateCustomerInfoBloc _bloc) {
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
              updateCustomerCode(_bloc);
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
              updateCustomerCode(_bloc);
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

  Row secondRow(UpdateCustomerInfoBloc _bloc) {
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

  Row thirdRow(UpdateCustomerInfoBloc _bloc) {
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
              if (_passwordController.text.isNotEmpty) {
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
      ],
    );
  }
}
