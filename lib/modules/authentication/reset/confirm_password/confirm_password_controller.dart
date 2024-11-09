import 'package:deemmi/core/utils/validator/format_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConfirmPasswordController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final RxnBool _isPasswordFormatCorrect = RxnBool();

  bool? get isPasswordFormatCorrect => _isPasswordFormatCorrect.value;

  final RxnBool _isConfirmPasswordMatched = RxnBool();

  bool? get isConfirmPasswordMatched => _isConfirmPasswordMatched.value;

  @override
  onReady() {
    super.onReady();
    confirmPasswordController.addListener(() {

    });
  }

  checkPasswordInfo() {
    _isPasswordFormatCorrect.value = passwordController.text.isStrongPassword();
    _isConfirmPasswordMatched.value =
        confirmPasswordController.text == passwordController.text;
    return isPasswordFormatCorrect! && isConfirmPasswordMatched!;
  }

  resetPasswordError() {
    _isPasswordFormatCorrect.value = null;
  }
}
