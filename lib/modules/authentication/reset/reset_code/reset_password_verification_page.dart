import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/authentication/reset/reset_code/reset_password_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/global_widgets/primary_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class ResetPasswordVerificationPage extends StatefulWidget {
  const ResetPasswordVerificationPage({super.key});

  @override
  State<ResetPasswordVerificationPage> createState() =>
      _ResetPasswordVerificationPageState();
}

class _ResetPasswordVerificationPageState
    extends State<ResetPasswordVerificationPage> {
  final _controller = Get.find<ResetPasswordVerificationController>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: AppColor.secondaryBgColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              stringRes(context)!.resetPasswordLabel,
              style: textTheme(context).displayLarge!.copyWith(
                    fontSize: 24,
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 4,
            ),
            Obx(
              () => Text.rich(
                TextSpan(
                  text: stringRes(context)!.otpHasBeenSentTo,
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: AppColor.secondaryContentGray),
                  children: [
                    TextSpan(
                      text: ' ${_controller.userEmail} ',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.secondaryContentGray),
                    ),
                    TextSpan(
                      text: stringRes(context)!.pleaseFillInTheOtp,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColor.secondaryContentGray),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Obx(() => pinCodeWidget(context)),
            const SizedBox(
              height: 24.0,
            ),
            Obx(
              () => submitButton(),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Obx(
                () => resendOtpButton(
                  _controller.canRequestOtp,
                  context,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  submitButton() {
    if (_controller.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.secondary500),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          title: stringRes(context)!.confirmLabel,
          onPressed: _controller.isOtpCompleted ? _submit : null,
          color: AppColor.primary500,
        ),
      );
    }
  }

  Widget pinCodeWidget(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 47,
      height: 48,
      textStyle: Theme.of(context).textTheme.headline5,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.borderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.primary500,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final disabledPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: AppColor.disableColor,
        border: Border.all(
          color: AppColor.disableColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.redError,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Pinput(
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      enabled: true,
      readOnly: false,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusPinTheme,
      disabledPinTheme: disabledPinTheme,
      errorPinTheme: errorPinTheme,
      forceErrorState: _controller.otpErrorText != null,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => {},
      controller: _controller.otpController,
      errorText: _controller.otpErrorText,
    );
  }

  Widget resendOtpButton(bool canRequest, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!_controller.canRequestOtp)
          const Icon(Icons.timer_outlined,
              color: AppColor.secondaryContentGray),
        if (!_controller.canRequestOtp) const SizedBox(width: 8),
        if (!_controller.canRequestOtp)
          Text(
            _controller.remainingCount,
            style: textTheme(context).bodyLarge?.copyWith(
                  color: AppColor.secondaryContentGray,
                ),
          ),
        if (!_controller.canRequestOtp) const SizedBox(width: 16),
        TextButton(
          onPressed: _controller.canRequestOtp
              ? () {
                  _controller.clearOtp();
                  _controller.requestOtp();
                }
              : null,
          child: Text(
            stringRes(context)!.resendOtpLabel,
          ),
        ),
      ],
    );
  }

  _submit() async {
    try {
      _controller.showLoading(true);
      await _controller.verifyOtp();
      _navigateToConfirmResetPassword();
    } catch (e) {
      _controller.handleOtpError(e);
      debugPrint(e.toString());
    } finally {
      _controller.showLoading(false);
    }
  }

  _navigateToConfirmResetPassword() {
    Get.toNamed(Routes.resetPasswordConfirm);
  }
}
