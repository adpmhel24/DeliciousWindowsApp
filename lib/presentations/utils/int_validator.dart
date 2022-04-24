import 'package:formz/formz.dart';

enum IntFieldValidator { invalid }

class IntField extends FormzInput<String, IntFieldValidator> {
  const IntField.pure() : super.pure('');
  const IntField.dirty([String value = '']) : super.dirty(value);

  @override
  IntFieldValidator? validator(String? value) {
    try {
      int.parse(value ?? "");
      return null;
    } on FormatException catch (_) {
      return IntFieldValidator.invalid;
    }
  }
}
