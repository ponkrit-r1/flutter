import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final AuthenticationAPI authenticationAPI;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final _isInformationCompleted = false.obs;

  bool get isInformationCompleted => _isInformationCompleted.value;

  Function(String)? displayError;

  SignInController(this.authenticationAPI);

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
    _isInformationCompleted.value =
        emailController.text.isEmail && passwordController.text.isNotEmpty;
  }

  signIn() async {
    try {
      _isLoading.value = true;
      await authenticationAPI.signIn(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
