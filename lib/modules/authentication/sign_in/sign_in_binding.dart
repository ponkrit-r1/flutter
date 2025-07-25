import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignInController(AuthenticationAPI(
        Get.find(),
        Get.find(),
      )),
    );
  }
}
