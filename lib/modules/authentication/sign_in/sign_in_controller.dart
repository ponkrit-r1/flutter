import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:deemmi/core/data/app_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';


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
    _isLoading.value = true;
    await authenticationAPI.signIn(
      emailController.text,
      passwordController.text,
    );
    _isLoading.value = false;
  }

void signOut() async {
    try {

      await Get.find<AppStorage>().logout();
 
       emailController.clear();
      passwordController.clear();
      _isLoading.value = false;
      _isInformationCompleted.value = false;

       Get.offAllNamed(Routes.signIn);

    } catch (error) {
      print("Error during sign-out: $error");
    }
  }


  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
}
