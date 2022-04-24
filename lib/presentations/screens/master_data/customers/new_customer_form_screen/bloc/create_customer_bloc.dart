import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:delicious_inventory_system/data/models/models.dart';
import 'package:delicious_inventory_system/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:formz/formz.dart';

import '../../../../../utils/confirm_password_validator.dart';
import '../../../../../utils/email_validator.dart';
import '../../../../../utils/string_validator.dart';
import '../../../../../utils/double_validator.dart';
import '../../../../../utils/int_validator.dart';

part 'create_customer_event.dart';
part 'create_customer_state.dart';

class CreateCustomerBloc
    extends Bloc<CreateCustomerEvent, CreateCustomerState> {
  CreateCustomerBloc() : super(const CreateCustomerState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<CustomerCodeChanged>(_onCustomerCodeChanged);
    on<CustsTypeChanged>(_onCustsTypeChanged);
    on<ContactNumberChanged>(_onContactNumberChanged);
    on<EmailChanged>(_onEmailChanged);
    on<CustomerSalesDiscountChanged>(_onCustomerSalesDiscountChanged);
    on<CustomerPickupDiscountChanged>(_onCustomerPickupDiscountChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<AddedCustomerAddress>(_onAddedCustomerAddress);
    on<RemoveAddressByIndex>(_onRemoveAddressByIndex);
    on<NewCustomerSubmitted>(_onNewCustomerSubmitted);
  }

  void _onFirstNameChanged(
      FirstNameChanged event, Emitter<CreateCustomerState> emit) {
    final firstName = StringField.dirty(event.firstName.text);

    emit(
      state.copyWith(
        firstName: firstName,
        status: Formz.validate(
          [
            firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onLastNameChanged(
      LastNameChanged event, Emitter<CreateCustomerState> emit) {
    final lastName = StringField.dirty(event.lastName.text);
    emit(
      state.copyWith(
        lastName: lastName,
        status: Formz.validate(
          [
            lastName,
            state.firstName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onCustomerCodeChanged(
      CustomerCodeChanged event, Emitter<CreateCustomerState> emit) {
    final custCode = StringField.dirty(event.custCode.text);
    emit(
      state.copyWith(
        custCode: custCode,
        status: Formz.validate(
          [
            state.lastName,
            state.firstName,
            custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onCustsTypeChanged(
      CustsTypeChanged event, Emitter<CreateCustomerState> emit) {
    final custType = IntField.dirty(event.custTypeModel.id.toString());
    DoubleField salesDiscount = state.salesDiscount;
    DoubleField pickupDiscount = state.pickupDiscount;
    StringField username = state.username;
    StringField password = state.password;
    ConfirmPasswordField confirmPassword = state.confirmPassword;

    if (event.custTypeModel.code.toLowerCase() == 'partner') {
      salesDiscount = const DoubleField.pure();
      pickupDiscount = const DoubleField.pure();
      username = const StringField.pure();
      password = const StringField.pure();
      confirmPassword = const ConfirmPasswordField.pure();
    }
    emit(
      state.copyWith(
        custType: custType,
        salesDiscount: salesDiscount,
        pickupDiscount: pickupDiscount,
        username: username,
        password: password,
        confirmPassword: confirmPassword,
        status: Formz.validate(
          [
            custType,
            state.firstName,
            state.lastName,
            state.custCode,
          ],
        ),
      ),
    );
  }

  void _onContactNumberChanged(
      ContactNumberChanged event, Emitter<CreateCustomerState> emit) {
    final contactNumber = StringField.dirty(event.contactNumber.text);
    emit(
      state.copyWith(
        contactNumber: contactNumber,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<CreateCustomerState> emit) {
    final emailAddress = EmailField.dirty(event.email.text);
    emit(
      state.copyWith(
        emailAddress: emailAddress,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onCustomerSalesDiscountChanged(
      CustomerSalesDiscountChanged event, Emitter<CreateCustomerState> emit) {
    final salesDiscount = DoubleField.dirty(event.salesDiscount.text);
    emit(
      state.copyWith(
        salesDiscount: salesDiscount,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onCustomerPickupDiscountChanged(
      CustomerPickupDiscountChanged event, Emitter<CreateCustomerState> emit) {
    final pickupDiscount = DoubleField.dirty(event.pickupDiscount.text);
    emit(
      state.copyWith(
        pickupDiscount: pickupDiscount,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onUsernameChanged(
      UsernameChanged event, Emitter<CreateCustomerState> emit) {
    final username = StringField.dirty(event.username.text);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<CreateCustomerState> emit) {
    final password = StringField.dirty(event.password.text);
    final confirmPassword = ConfirmPasswordField.dirty({
      "password": password.value,
      "confirmPassword": state.confirmPassword.value?["confirmPassword"] ?? ""
    });
    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<CreateCustomerState> emit) {
    final confirmPassword = ConfirmPasswordField.dirty({
      "password": state.password.value,
      "confirmPassword": event.confirmPassword.text
    });

    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onAddedCustomerAddress(
      AddedCustomerAddress event, Emitter<CreateCustomerState> emit) {
    List<CustomerAddressModel> addresses = [...state.addresses, event.address];
    emit(
      state.copyWith(
        addresses: addresses,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onRemoveAddressByIndex(
      RemoveAddressByIndex event, Emitter<CreateCustomerState> emit) {
    List<CustomerAddressModel> addresses = [...state.addresses];
    addresses.removeAt(event.index);
    emit(
      state.copyWith(
        addresses: addresses,
        status: Formz.validate(
          [
            state.firstName,
            state.lastName,
            state.custCode,
            state.custType,
          ],
        ),
      ),
    );
  }

  void _onNewCustomerSubmitted(
      NewCustomerSubmitted event, Emitter<CreateCustomerState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Map<String, dynamic> data = {
      "header": {
        "first_name": state.firstName.value,
        "last_name": state.lastName.value,
        "cust_type": state.custType.value,
        "code": state.custCode.value,
        "email": state.emailAddress.value,
        "contact_number": state.contactNumber.value,
        "allowed_disc": state.salesDiscount.value,
        "pickup_disc": state.pickupDiscount.value,
      },
      "user": {
        "username": state.username.value,
        "password": state.password.value,
      },
      "addresses": state.addresses.map((e) => e.toJson()).toList(),
    };
    final CustomersRepo _custRepo = AppRepo.customersRepository;
    try {
      String message = await _custRepo.createNewCustomer(data);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        message: message,
      ));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    }
  }
}
