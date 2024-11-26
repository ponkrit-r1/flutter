import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:deemmi/core/utils/validator/format_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ConfirmPasswordController extends GetxController {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final RxnBool _isPasswordFormatCorrect = RxnBool();

  ConfirmPasswordController(this._authenticationAPI);

  bool? get isPasswordFormatCorrect => _isPasswordFormatCorrect.value;

  final RxnBool _isConfirmPasswordMatched = RxnBool();

  bool? get isConfirmPasswordMatched => _isConfirmPasswordMatched.value;

  final AuthenticationAPI _authenticationAPI;

  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  onReady() {
    super.onReady();
    confirmPasswordController.addListener(() {});
  }

  setNewPassword() {
    _isLoading.value = true;
    _authenticationAPI.setPassword(
      passwordController.text,
      confirmPasswordController.text,
    );
    _isLoading.value = false;
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
