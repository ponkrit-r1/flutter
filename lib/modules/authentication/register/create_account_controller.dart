import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:deemmi/core/domain/auth/create_account_request.dart';
import 'package:deemmi/core/domain/auth/term_data.dart';
import 'package:deemmi/core/domain/auth/user_model.dart';
import 'package:deemmi/core/network/app_error.dart';
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

  final RxnString _userNameTextError = RxnString();

  String? get userNameTextError => _userNameTextError.value;

  final RxnString _firstNameTextError = RxnString();

  String? get firstNameTextError => _firstNameTextError.value;

  final RxnString _lastNameTextError = RxnString();

  String? get lastNameTextError => _lastNameTextError.value;

  final RxnString _emailTextError = RxnString();

  String? get emailTextError => _emailTextError.value;

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

  // getTermData() async {
  //   print("------call get TermData-------");
  //   termData = await authenticationAPI.getLatestConditionFile();
  // }
  getTermData() async {
    print("------call get TermData-------");
    try {
      var response = await authenticationAPI.getLatestConditionFile();
      termData = response;
      print("------TermData fetched successfully: ${termData?.id}-------");
    } catch (e) {
      print("------Error fetching TermData: ${e.toString()}-------");
    } finally {
      update();
    }
  }

  setTermAccept(bool termAccepted) {
    _isTermAccepted.value = termAccepted;
    checkInformation();
  }

  setCreateAccountApiError(dynamic response) {
    _emailTextError.value = response['email'] != null
        ? List.from(response['email']).firstOrNull?.toString()
        : null;
    _firstNameTextError.value = response['first_name'] != null
        ? List.from(response['first_name']).firstOrNull?.toString()
        : null;
    _lastNameTextError.value = response['last_name'] != null
        ? List.from(response['last_name']).firstOrNull?.toString()
        : null;
    _userNameTextError.value = response['username'] != null
        ? List.from(response['username']).firstOrNull?.toString()
        : null;
  }

  clearFieldError() {
    _emailTextError.value = null;
    _firstNameTextError.value = null;
    _lastNameTextError.value = null;
    _userNameTextError.value = null;
  }

  Future<User?> createAccount() async {
    print("---register api----");
    if (termData == null) {
      print("---start call termData----");
      return null;
    }
    try {
      print("=======******call register api=====");
      _isLoading.value = true;
      var accountResponse = await authenticationAPI.register(
        CreateAccountModel(
          username: userNameController.text,
          password: passwordController.text,
          password2: confirmPasswordController.text,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          confirmedConditionId:
              termData?.id ?? 0, // ใส่ค่า default หาก termData เป็น null
        ),
      );
      clearFieldError();
      print("---API response received---");
      print("Account response: $accountResponse");
      return accountResponse;
    } catch (e) {
      print("=====register api error 2 ======$e");

      if (e is AppError) {
        setCreateAccountApiError(e.response);
        debugPrint(e.response);
        print("=====register api error ======" + e.response);
      } else {
        print("Unexpected error type: ${e.runtimeType}");
      }
      return null;
    } finally {
      _isLoading.value = false;
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
        confirmPasswordController.text.isNotEmpty &&
        isTermAccepted;
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
