import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:deemmi/core/domain/auth/create_account_request.dart';
import 'package:deemmi/core/domain/auth/term_data.dart';
import 'package:deemmi/core/domain/auth/user_model.dart';
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

  TermData? termData;

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var userNameController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  final AuthenticationAPI authenticationAPI;

  CreateAccountController({required this.authenticationAPI});

  final _isInformationCompleted = false.obs;

  bool get isInformationCompleted => _isInformationCompleted.value;

  final _isTermAccepted = false.obs;

  bool get isTermAccepted => _isTermAccepted.value;

  Function(String)? displayError;

  @override
  void onReady() {
    super.onReady();
    getTermData();
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

  getTermData() async {
    termData = await authenticationAPI.getLatestConditionFile();
  }

  setTermAccept(bool termAccepted) {
    _isTermAccepted.value = termAccepted;
  }

  Future<User?> createAccount() async {
    if (termData == null) return null;
    try {
      return await authenticationAPI.register(
        CreateAccountModel(
          username: userNameController.text,
          password: passwordController.text,
          password2: confirmPasswordController.text,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          confirmedConditionId: termData!.id,
        ),
      );
    } catch (e) {
      debugPrint(
        e.toString(),
      );
      return null;
    }
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
