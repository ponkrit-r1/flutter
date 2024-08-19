import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/authentication/verification/otp_verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _controller = Get.find<OtpVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              stringRes(context)!.userVerificationLabel,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 36,
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
                  style: Theme.of(Get.context!)
                      .textTheme
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
            pinCodeWidget(context),
            const SizedBox(
              height: 24.0,
            ),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  title: stringRes(context)!.confirmLabel,
                  onPressed: _controller.isOtpCompleted ? _submit : null,
                  color: AppColor.primary500,
                ),
              ),
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

  // Widget _errorText(BuildContext context) {
  //   if (controller.otpError.value != null) {
  //     return Row(
  //       children: [
  //         Assets.icErrorField.svg(),
  //         const SizedBox(
  //           width: 4,
  //         ),
  //         Text(
  //           controller.otpError.value!,
  //           style: Theme.of(context).textTheme.caption1.copyWith(
  //                 color: AppColors.negativeColor,
  //               ),
  //         )
  //       ],
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

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

    return Pinput(
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      enabled: true,
      readOnly: false,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusPinTheme,
      disabledPinTheme: disabledPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => {},
      controller: _controller.otpController,
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
    Get.toNamed(Routes.createAccountSuccess);
  }
}
