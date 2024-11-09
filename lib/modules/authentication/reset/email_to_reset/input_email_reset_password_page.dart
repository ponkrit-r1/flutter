import 'package:deemmi/core/global_widgets/primary_button.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/authentication/reset/email_to_reset/input_email_reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global_widgets/pettagu_text_field.dart';
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
    return SizedBox(
      height: 48,
      width: double.maxFinite,
      child: PrimaryButton(
        color: AppColor.primary500,
        onPressed: _controller.isInformationCompleted
            ? () {
                navigateToResetPassword();
              }
            : null,
        title: stringRes(context)!.submitLabel,
      ),
    );
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
