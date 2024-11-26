import 'package:get/get.dart';

import '../../../../core/data/api/authentication_api.dart';
import 'confirm_password_controller.dart';

class ConfirmPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ConfirmPasswordController(
        AuthenticationAPI(
          Get.find(),
          Get.find(),
        ),
      ),
    );
  }
}
