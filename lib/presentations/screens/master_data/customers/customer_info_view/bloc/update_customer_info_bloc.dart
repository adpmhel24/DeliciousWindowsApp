import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:formz/formz.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repositories.dart';
import '../../../../../utils/bool_validator.dart';
import '../../../../../utils/double_validator.dart';
import '../../../../../utils/email_validator.dart';
import '../../../../../utils/int_validator.dart';
import '../../../../../utils/string_validator.dart';
import 'bloc.dart';

part 'update_customer_info_event.dart';
part 'update_customer_info_state.dart';

class UpdateCustomerInfoBloc
    extends Bloc<UpdateCustomerInfoEvent, UpdateCustomerInfoState> {
  final CustomerInfoViewBloc _customerInfoViewBloc;
  late StreamSubscription _custInfoViewBlocSubcription;
  late CustomerModel _customerModel;

  UpdateCustomerInfoBloc(this._customerInfoViewBloc)
      : super(const UpdateCustomerInfoState()) {
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
    on<CustomerActiveChanged>(_onCustomerActiveChanged);
    on<UpdateCustomerSubmitted>(_onUpdateCustomerSubmitted);

    _custInfoViewBlocSubcription =
        _customerInfoViewBloc.stream.listen((customerInfoState) {
      if (customerInfoState.fetchingStatus == CustomerInfoViewStatus.success) {
        _customerModel = customerInfoState.fetchedCustomer!;
      }
    });
  }

  void _onFirstNameChanged(
      FirstNameChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var firstName = StringField.dirty(event.firstName.text);

    if (_customerModel.firstName == event.firstName.text ||
        (_customerModel.firstName == null && event.firstName.text.isEmpty)) {
      firstName = const StringField.pure();
    }

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
      LastNameChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var lastName = StringField.dirty(event.lastName.text);
    if (_customerModel.lastName == event.lastName.text ||
        (_customerModel.lastName == null && event.lastName.text.isEmpty)) {
      lastName = const StringField.pure();
    }
    emit(
      state.copyWith(
        lastName: lastName,
        status: Formz.validate(
          [
            lastName,
          ],
        ),
      ),
    );
  }

  void _onCustomerCodeChanged(
      CustomerCodeChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var custCode = StringField.dirty(event.custCode.text);
    if (_customerModel.code == event.custCode.text ||
        (_customerModel.code == null && event.custCode.text.isEmpty)) {
      custCode = const StringField.pure();
    }
    emit(
      state.copyWith(
        custCode: custCode,
        status: Formz.validate(
          [
            custCode,
          ],
        ),
      ),
    );
  }

  void _onCustsTypeChanged(
      CustsTypeChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var custType = IntField.dirty(event.custTypeModel.id.toString());
    DoubleField salesDiscount = state.salesDiscount;
    DoubleField pickupDiscount = state.pickupDiscount;
    StringField username = state.username;
    StringField password = state.password;

    if (_customerModel.custType == event.custTypeModel.id) {
      custType = const IntField.pure();
    }

    if (event.custTypeModel.code.toLowerCase() == 'partner') {
      salesDiscount = const DoubleField.pure();
      pickupDiscount = const DoubleField.pure();
      username = const StringField.pure();
      password = const StringField.pure();
    }
    emit(
      state.copyWith(
        custType: custType,
        salesDiscount: salesDiscount,
        pickupDiscount: pickupDiscount,
        username: username,
        password: password,
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
      ContactNumberChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var contactNumber = StringField.dirty(event.contactNumber.text);
    if (_customerModel.contactNumber == event.contactNumber.text ||
        (_customerModel.contactNumber == null &&
            event.contactNumber.text.isEmpty)) {
      contactNumber = const StringField.pure();
    }
    emit(
      state.copyWith(
        contactNumber: contactNumber,
        status: Formz.validate(
          [
            contactNumber,
          ],
        ),
      ),
    );
  }

  void _onEmailChanged(
      EmailChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var emailAddress = EmailField.dirty(event.email.text);
    if (_customerModel.email == event.email.text ||
        (_customerModel.email == null && event.email.text.isEmpty)) {
      emailAddress = const EmailField.pure();
    }
    emit(
      state.copyWith(
        emailAddress: emailAddress,
        status: Formz.validate(
          [
            emailAddress,
          ],
        ),
      ),
    );
  }

  void _onCustomerSalesDiscountChanged(CustomerSalesDiscountChanged event,
      Emitter<UpdateCustomerInfoState> emit) {
    var salesDiscount = DoubleField.dirty(event.salesDiscount.text);
    if (_customerModel.allowedDisc == double.parse(event.salesDiscount.text) ||
        (_customerModel.allowedDisc == null &&
            event.salesDiscount.text.isEmpty)) {
      salesDiscount = const DoubleField.pure();
    }
    emit(
      state.copyWith(
        salesDiscount: salesDiscount,
        status: Formz.validate(
          [salesDiscount],
        ),
      ),
    );
  }

  void _onCustomerPickupDiscountChanged(CustomerPickupDiscountChanged event,
      Emitter<UpdateCustomerInfoState> emit) {
    var pickupDiscount = DoubleField.dirty(event.pickupDiscount.text);
    if (_customerModel.pickupDisc == double.parse(event.pickupDiscount.text) ||
        (_customerModel.pickupDisc == null &&
            event.pickupDiscount.text.isEmpty)) {
      pickupDiscount = const DoubleField.pure();
    }
    emit(
      state.copyWith(
        pickupDiscount: pickupDiscount,
        status: Formz.validate(
          [pickupDiscount],
        ),
      ),
    );
  }

  void _onUsernameChanged(
      UsernameChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var username = StringField.dirty(event.username.text);
    String? existingUserName = _customerModel.user?['username'];
    if ((existingUserName == null && event.username.text.isEmpty) ||
        existingUserName == username.value) {
      username = const StringField.pure();
    }

    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [username, state.password],
        ),
      ),
    );
  }

  void _onCustomerActiveChanged(
      CustomerActiveChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var isActive = BoolField.dirty(event.isActive);

    if (_customerModel.isActive == event.isActive) {
      isActive = const BoolField.pure();
    }

    emit(
      state.copyWith(
        isActive: isActive,
        status: Formz.validate(
          [isActive],
        ),
      ),
    );
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<UpdateCustomerInfoState> emit) {
    var password = StringField.dirty(event.password.text);
    if (_customerModel.user!['password'] == password.value ||
        (_customerModel.user!['password'] == null &&
            event.password.text.isEmpty)) {
      password = const StringField.pure();
    }
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [password],
        ),
      ),
    );
  }

  void _onUpdateCustomerSubmitted(UpdateCustomerSubmitted event,
      Emitter<UpdateCustomerInfoState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    Map<String, dynamic> data = {};

    state.toMap().forEach((key, value) {
      if (key == 'header') {
        value.forEach((k, v) {
          if (!v.pure) {
            data[k] = v.value;
          }
        });
      } else if (key == 'user') {
        if (value['username'].valid && value['password'].valid) {
          data['user'] = {
            "username": value['username'].value,
            "password": value['password'].value,
          };
        }
      }
    });

    final CustomersRepo _custRepo = AppRepo.customersRepository;
    try {
      CustomerModel customer = await _custRepo.updateCustomer(
          customerId: event.customerId, data: data);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));

      _customerModel = customer;
      _customerInfoViewBloc.add(UpdatedCustomerInfo(_customerModel));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    }
  }

  @override
  Future<void> close() {
    _custInfoViewBlocSubcription.cancel();
    return super.close();
  }
}
