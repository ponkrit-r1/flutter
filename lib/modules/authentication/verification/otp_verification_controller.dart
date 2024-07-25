import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  final RxString _userEmail = ''.obs;

  String get userEmail => _userEmail.value;

  final RxBool _isOtpComplete = false.obs;

  bool get isOtpCompleted => _isOtpComplete.value;

  final RxBool _canRequestOtp = false.obs;

  bool get canRequestOtp => _isOtpComplete.value;



  TextEditingController otpController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    _userEmail.value = 'info@petagu.me';
    otpController.addListener(() {
      _isOtpComplete.value = otpController.text.length == 6;
    });
  }
}
