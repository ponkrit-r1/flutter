import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/authentication/reset/email_to_reset/input_email_reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global_widgets/pettagu_text_field.dart';
import '../../../../core/global_widgets/primary_style_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class InputEmailResetPasswordPage extends StatefulWidget {
  const InputEmailResetPasswordPage({super.key});

  @override
  State<InputEmailResetPasswordPage> createState() =>
      _InputEmailResetPasswordPageState();
}

class _InputEmailResetPasswordPageState
    extends State<InputEmailResetPasswordPage> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  final _controller = Get.find<InputEmailResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: AppColor.secondaryBgColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stringRes(context)!.resetPasswordLabel,
                    style: textTheme(context).displayMedium?.copyWith(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    stringRes(context)!.resetPasswordDescription,
                    style: textTheme(context).bodyLarge?.copyWith(
                          color: AppColor.secondaryContentGray,
                        ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _emailForm(),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() => _submitResetPassword()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submitResetPassword() {
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
        height: 48,
        width: double.infinity,
        child: PrimaryStyleButton(
          color: AppColor.primary500,
          onPressed: _controller.isInformationCompleted
              ? () {
                  onResetPasswordClicked();
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              stringRes(context)!.submitLabel,
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  onResetPasswordClicked() async {
    await _controller.requestResetPasswordOtp();
    navigateToResetPassword();
  }

  navigateToResetPassword() {
    Get.toNamed(Routes.resetPasswordVerification, arguments: {
      RouteParams.userEmail: _controller.emailController.text,
    });
  }

  _emailForm() {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.emailAddress,
      controller: _controller.emailController,
      fillColor: Colors.white,
    );
  }

  navigateToVerifyOtpToResetEmail() {}
}
