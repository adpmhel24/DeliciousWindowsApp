import 'package:formz/formz.dart';

enum StringFieldValidator { empty }

class StringField extends FormzInput<String, StringFieldValidator> {
  const StringField.pure() : super.pure('');
  const StringField.dirty([String value = '']) : super.dirty(value);

  @override
  StringFieldValidator? validator(String? value) {
    return value?.isNotEmpty == true ? null : StringFieldValidator.empty;
  }
}
