import 'package:deemmi/core/utils/validator/format_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  var emailController = TextEditingController();

  final RxnBool _isEmailFormatCorrect = RxnBool();

  bool? get isEmailFormatCorrect => _isEmailFormatCorrect.value;

  final RxnBool _isPasswordFormatCorrect = RxnBool();

  bool? get isPasswordFormatCorrect => _isPasswordFormatCorrect.value;

  final RxnBool _isConfirmPasswordMatched = RxnBool();

  bool? get isConfirmPasswordMatched => _isConfirmPasswordMatched.value;

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var userNameController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  final _isInformationCompleted = false.obs;

  bool get isInformationCompleted => _isInformationCompleted.value;

  final _isTermAccepted = false.obs;

  bool get isTermAccepted => _isTermAccepted.value;

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

    confirmPasswordController.addListener(() {
      checkInformation();
    });
  }

  setTermAccept(bool termAccepted) {
    _isTermAccepted.value = termAccepted;
  }

  bool checkAndDisplayFieldError() {
    _isEmailFormatCorrect.value = emailController.text.validateEmail();
    _isPasswordFormatCorrect.value = passwordController.text.isStrongPassword();
    _isConfirmPasswordMatched.value =
        confirmPasswordController.text == passwordController.text;
    return emailController.text.validateEmail() &&
        passwordController.text.isStrongPassword() &&
        (confirmPasswordController.text == passwordController.text);
  }

  checkInformation() {
    _isInformationCompleted.value = emailController.text.validateEmail() &&
        passwordController.text.isNotEmpty &&
        userNameController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userNameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }
}
