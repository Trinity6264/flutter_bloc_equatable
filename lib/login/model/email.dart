import 'package:formz/formz.dart';

enum EmailValidationErr { invalid }

class Email extends FormzInput<String, EmailValidationErr> {
  const Email.pure([super.value ='']) : super.pure();
 const  Email.dirty([super.value ='']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

   

  @override
  EmailValidationErr? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationErr.invalid;
  }
}
