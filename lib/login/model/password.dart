import 'package:formz/formz.dart';

enum PasswordValidationErr { invalid }

class Password extends FormzInput<String, PasswordValidationErr> {
  const Password.dirty([super.value ='']) : super.dirty();
  const Password.pure([super.value ='']) : super.pure();

  @override
  PasswordValidationErr? validator(String value) {
    if (value.length < 6) PasswordValidationErr.invalid;
    return null;
  }
}
