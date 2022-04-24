import 'package:formz/formz.dart';

enum BoolFieldValidator { invalid }

class BoolField extends FormzInput<bool?, BoolFieldValidator> {
  const BoolField.pure() : super.pure(null);
  const BoolField.dirty(bool value) : super.dirty(value);

  @override
  BoolFieldValidator? validator(bool? value) {
    return value != null ? null : BoolFieldValidator.invalid;
  }
}
