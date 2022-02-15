import 'dart:io';

import 'package:delicious_windows_app/data/repositories/app_repo.dart';
import 'package:delicious_windows_app/data/repositories/auth_repo.dart';
import 'package:delicious_windows_app/presentations/utils/text_field_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'bloc.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(const LoginFormState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ProceedLogin>(_onProceedLogin);
  }

  final AuthRepository _authRepository = AppRepo.authRepository;

  void _onUsernameChanged(UsernameChanged event, Emitter<LoginFormState> emit) {
    final username = TextFieldModel.dirty(event.usernameController.text);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([
          username,
          state.password,
        ]),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final password = TextFieldModel.dirty(event.passwordController.text);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          password,
          state.username,
        ]),
      ),
    );
  }

  void _onProceedLogin(ProceedLogin event, Emitter<LoginFormState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    final username = state.username.value;
    final password = state.password.value;
    try {
      await _authRepository.loginWithCredentials(
          username: username, password: password);
      emit(
        state.copyWith(status: FormzStatus.submissionSuccess),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
            status: FormzStatus.submissionFailure, message: e.message),
      );
    }
  }
}
