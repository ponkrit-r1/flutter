import 'dart:async';

import 'package:deemmi/core/data/app_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/data/api/authentication_api.dart';

class OtpVerificationController extends GetxController {
  final RxString _userEmail = ''.obs;
  final int _userId;
  final String _password;
  final String _username;
  static const otpLimit = 60;

  OtpVerificationController(
    this.registeredEmail,
    this._userId,
    this.authenticationAPI,
    this._username,
    this._password,
    this.storage,
  );

  String get userEmail => _userEmail.value;

  final RxBool _isOtpComplete = false.obs;

  bool get isOtpCompleted => _isOtpComplete.value;

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
    var response = await authenticationAPI.verifyOtp(
      _userEmail.value,
      otpController.text,
    );
    scheduleTimeout();
    return response;
  }

  Future<dynamic> login() async {
    await authenticationAPI.signIn(userEmail, _password);
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
