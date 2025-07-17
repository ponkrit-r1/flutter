import 'package:email_validator/email_validator.dart';

extension StringFormatValidation on String {
  bool isStrongPassword() {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$');
    return regex.hasMatch(this);
  }

  bool validateEmail() {
    return EmailValidator.validate(this);
  }

  bool isThaiPhoneNumber() {
    RegExp thaiPhoneRegex =
        RegExp(r'^(0\d{8,9}|\+66\d{8,9}|\+66[2-9]\d{7,8}|0[2-9]\d{7,8})$');
    return thaiPhoneRegex.hasMatch(this);
  }

  bool isValidUsername() {
    RegExp usernameRegex = RegExp(r'^[a-zA-Z._-]{2,}$');
    return usernameRegex.hasMatch(this);
  }
}
