import 'package:deemmi/modules/authentication/verification/otp_verification_controller.dart';
import 'package:deemmi/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../core/data/api/authentication_api.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    String email = Get.arguments?[RouteParams.userEmail] ?? '';
    int userId = Get.arguments?[RouteParams.userId];
    Get.lazyPut(
      () => OtpVerificationController(
        email,
        userId,
        AuthenticationAPI(
          Get.find(),
          Get.find(),
        ),
      ),
    );
  }
}
