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
    RegExp thaiPhoneRegex =  RegExp(r'^(0\d{8,9}|\+66\d{8,9}|\+66[2-9]\d{7,8}|0[2-9]\d{7,8})$');
    return thaiPhoneRegex.hasMatch(this);
  }
}
