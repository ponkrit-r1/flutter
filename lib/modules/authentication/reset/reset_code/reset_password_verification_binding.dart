import 'package:deemmi/modules/authentication/reset/reset_code/reset_password_verification_controller.dart';
import 'package:get/get.dart';

import '../../../../core/data/api/authentication_api.dart';
import '../../../../routes/app_routes.dart';

class ResetPasswordVerificationBinding extends Bindings {
  @override
  void dependencies() {
    String email = Get.arguments?[RouteParams.userEmail] ?? '';
    int userId = Get.arguments?[RouteParams.userId] ?? 0;
    Get.lazyPut(
      () => ResetPasswordVerificationController(
        email,
        userId,
        AuthenticationAPI(
          Get.find(),
          Get.find(),
        ),
        Get.find(),
      ),
    );
  }
}
