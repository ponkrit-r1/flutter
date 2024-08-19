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
}
