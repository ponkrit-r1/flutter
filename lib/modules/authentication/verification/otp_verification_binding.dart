import 'package:deemmi/modules/authentication/verification/otp_verification_controller.dart';
import 'package:deemmi/routes/app_routes.dart';
import 'package:get/get.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    String email = Get.arguments?[RouteParams.userEmail] ?? '';
    Get.lazyPut(() => OtpVerificationController(email));
  }
}
