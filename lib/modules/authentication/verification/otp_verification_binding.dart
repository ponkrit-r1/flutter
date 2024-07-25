import 'package:deemmi/modules/authentication/verification/otp_verification_controller.dart';
import 'package:get/get.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpVerificationController());
  }
}
