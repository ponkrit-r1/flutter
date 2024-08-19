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
      _isEmailFormatCorrect.value = emailController.text.validateEmail();
    });
    passwordController.addListener(() {
      checkInformation();
      _isPasswordFormatCorrect.value = passwordController.text.isStrongPassword();
    });

    confirmPasswordController.addListener(() {
      checkInformation();
      _isConfirmPasswordMatched.value =
          confirmPasswordController.text == passwordController.text;
    });
  }

  setTermAccept(bool termAccepted) {
    _isTermAccepted.value = termAccepted;
  }

  checkInformation() {
    _isInformationCompleted.value = emailController.text.validateEmail() &&
        passwordController.text.isNotEmpty &&
        userNameController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
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
