import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final _isInformationCompleted = false.obs;
  bool get isInformationCompleted => _isInformationCompleted.value;

  Function(String)? displayError;

  @override
  void onReady() {
    super.onReady();
    emailController.addListener(() {
      checkInformation();
    });
    passwordController.addListener(() {
      checkInformation();
    });
  }

  checkInformation() {
    _isInformationCompleted.value = emailController.text.isEmail && passwordController.text.isNotEmpty;
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
