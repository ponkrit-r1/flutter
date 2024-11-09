import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:deemmi/modules/authentication/reset/email_to_reset/input_email_reset_password_controller.dart';
import 'package:get/get.dart';

class InputEmailResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => InputEmailResetPasswordController(
        AuthenticationAPI(
          Get.find(),
          Get.find(),
        ),
      ),
    );
  }
}
