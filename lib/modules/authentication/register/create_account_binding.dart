import 'package:deemmi/core/data/api/authentication_api.dart';
import 'package:get/get.dart';

import 'create_account_controller.dart';

class CreateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CreateAccountController(
        authenticationAPI: AuthenticationAPI(
          Get.find(),
          Get.find(),
        ),
      ),
    );
  }
}
