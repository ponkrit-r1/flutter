import 'package:email_validator/email_validator.dart';

extension StringFormatValidation on String {
  bool isStrongPassword() {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    return regex.hasMatch(this);
  }

  bool validateEmail() {
    return EmailValidator.validate(this);
  }

  bool isThaiPhoneNumber() {
    RegExp thaiPhoneRegex =  RegExp(r'^(\+66|0)?[689]\d{8}$');
    return thaiPhoneRegex.hasMatch(this);
  }
}
