import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InputEmailResetPasswordController extends GetxController {
  final AuthenticationAPI _authenticationAPI;
  var emailController = TextEditingController();

  InputEmailResetPasswordController(this._authenticationAPI);

  final _isInformationCompleted = false.obs;

  bool get isInformationCompleted => _isInformationCompleted.value;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  @override
  void onReady() {
    super.onReady();
    emailController.addListener(() {
      checkInformation();
    });
  }

  checkInformation() {
    _isInformationCompleted.value = emailController.text.isEmail;
  }

  requestResetPasswordOtp() {
    _isLoading.value = true;
    _authenticationAPI.resetPasswordOTP(emailController.text);
    _isLoading.value = false;
  }
}
