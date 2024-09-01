import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/data/api/authentication_api.dart';

class OtpVerificationController extends GetxController {
  final RxString _userEmail = ''.obs;
  final int _userId;
  static const otpLimit = 10;

  OtpVerificationController(
    this.registeredEmail,
    this._userId,
    this.authenticationAPI,
  );

  String get userEmail => _userEmail.value;

  final RxBool _isOtpComplete = false.obs;

  bool get isOtpCompleted => _isOtpComplete.value;

  final RxBool _canRequestOtp = false.obs;

  bool get canRequestOtp => _canRequestOtp.value;

  final AuthenticationAPI authenticationAPI;

  final String registeredEmail;

  final _timerCount = 0.obs;

  String get remainingCount {
    return '00:${_timerCount.toString().padLeft(2, '0')}';
  }

  Timer? _timer;

  TextEditingController otpController = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    requestOtp();
    _userEmail.value = registeredEmail;
    otpController.addListener(() {
      _isOtpComplete.value = (otpController.text.length == 6);
    });
  }

  @override
  void onClose() {
    _canRequestOtp.value = false;
    _timer?.cancel();
    super.onClose();
  }

  Future<dynamic> verifyOtp() async {
    try {
      await authenticationAPI.verifyOtp(
        _userEmail.value,
        otpController.text,
      );
      scheduleTimeout();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> requestOtp() async {
    try {
      await authenticationAPI.requestOtp(_userId, _userEmail.value);
      scheduleTimeout();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void scheduleTimeout([int seconds = otpLimit]) {
    _canRequestOtp.value = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), onTimerTick);
  }

  void onTimerTick(Timer timer) {
    _timerCount.value = otpLimit - timer.tick;
    if (_timerCount.value <= 0) {
      _canRequestOtp.value = true;
      timer.cancel();
    }
  }
}
