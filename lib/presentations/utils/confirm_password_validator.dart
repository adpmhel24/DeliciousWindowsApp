import 'dart:io';

import 'package:formz/formz.dart';

enum ConfirmPasswordFieldValidator { invalid }

class ConfirmPasswordField
    extends FormzInput<Map<String, dynamic>?, ConfirmPasswordFieldValidator> {
  const ConfirmPasswordField.pure() : super.pure(null);
  const ConfirmPasswordField.dirty(Map<String, dynamic> passwords)
      : super.dirty(passwords);

  @override
  ConfirmPasswordFieldValidator? validator(Map<String, dynamic>? value) {
    if (value != null) {
      try {
        if (value["password"] == value["confirmPassword"]) {
          return null;
        }
      } on HttpException catch (_) {
        return ConfirmPasswordFieldValidator.invalid;
      }
    }
    return ConfirmPasswordFieldValidator.invalid;
  }
}
