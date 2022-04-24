import 'package:formz/formz.dart';

enum DoubleFieldValidator { invalid }

class DoubleField extends FormzInput<String, DoubleFieldValidator> {
  const DoubleField.pure() : super.pure('');
  const DoubleField.dirty([String value = '']) : super.dirty(value);

  @override
  DoubleFieldValidator? validator(String? value) {
    try {
      double.parse(value ?? "");
      return null;
    } on FormatException catch (_) {
      return DoubleFieldValidator.invalid;
    }
  }
}
