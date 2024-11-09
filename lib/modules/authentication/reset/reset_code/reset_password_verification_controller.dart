import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/data/api/authentication_api.dart';
import '../../../../core/data/app_storage.dart';
import '../../../../core/network/app_error.dart';

class ResetPasswordVerificationController extends GetxController {
  final RxString _userEmail = ''.obs;
  final int _userId;
  static const otpLimit = 60;

  ResetPasswordVerificationController(
      this.registeredEmail,
      this._userId,
      this.authenticationAPI,
      this.storage,
      );

  String get userEmail => _userEmail.value;

  final RxBool _isOtpComplete = false.obs;

  bool get isOtpCompleted => _isOtpComplete.value;

  final RxnString _otpErrorText = RxnString();

  String? get otpErrorText => _otpErrorText.value;

  final RxBool _canRequestOtp = true.obs;

  bool get canRequestOtp => _canRequestOtp.value;

  final AuthenticationAPI authenticationAPI;

  final AppStorage storage;

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
    _userEmail.value = registeredEmail;
    otpController.addListener(() {
      _isOtpComplete.value = (otpController.text.length == 6);
    });
    scheduleTimeout();
  }

  @override
  void onClose() {
    _canRequestOtp.value = false;
    _timer?.cancel();
    super.onClose();
  }

  clearOtp() {
    otpController.clear();
  }

  Future<dynamic> verifyOtp() async {
    _otpErrorText.value = null;
    var response = await authenticationAPI.verifyResetEmail(
      _userEmail.value,
      otpController.text,
    );
    scheduleTimeout();
    return response;
  }

  handleOtpError(dynamic error) {
    var appError = (error as AppError).response;
    _otpErrorText.value = appError['detail'];
    otpController.text = '';
  }


  Future<void> requestOtp() async {
    try {
      _otpErrorText.value = null;
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