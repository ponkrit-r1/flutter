import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/authentication/reset/confirm_password/confirm_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/global_widgets/global_confirm_dialog.dart';
import '../../../../core/global_widgets/pettagu_text_field.dart';
import '../../../../core/global_widgets/primary_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/app_routes.dart';

class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({super.key});

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  final _controller = Get.find<ConfirmPasswordController>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: AppColor.secondaryBgColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stringRes(context)!.createNewPasswordLabel,
                    style: textTheme(context).displayLarge?.copyWith(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    stringRes(context)!.newPasswordLabel,
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: AppColor.textColor, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() => _passwordForm(context)),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() => _confirmPasswordForm(context)),
                  const SizedBox(
                    height: 16,
                  ),
                   _submitResetPassword(),
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
      width: double.infinity,
      child: PrimaryButton(
        title: stringRes(context)!.saveLabel,
        onPressed:
            () {
                if (_controller.checkPasswordInfo()) {
                  _showDialog();
                }
              }
          ,
        color: AppColor.primary500,
      ),
    );
  }

  _showDialog() {
    Get.dialog(
      ConfirmDialog(
        topWidget: Container(
            decoration: const BoxDecoration(
              color: AppColor.secondaryBgColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(24.0),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColor.secondary500,
              size: 32,
            )),
        confirmText: stringRes(context)!.closeLabel,
        onConfirm: () {
          Get.offAllNamed(Routes.signIn);
        },
        title: stringRes(context)!.passwordUpdatedLabel,
        description: stringRes(context)!.resetPasswordDescription,
        hideCancel: true,
        confirmColor: AppColor.primary500,
      ),
    );
  }

  _passwordForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: _controller.passwordController,
      fillColor: Colors.white,
      errorText: (_controller.isPasswordFormatCorrect == false)
          ? stringRes(context)!.invalidPasswordLabel
          : null,
      onPressed: () {
        if(_controller.isPasswordFormatCorrect == false) {
          _controller.resetPasswordError();
        }
      },
    );
  }

  _confirmPasswordForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: _controller.confirmPasswordController,
      fillColor: Colors.white,
      errorText: _controller.isConfirmPasswordMatched == false
          ? stringRes(context)!.passwordNotMatch
          : null,
    );
  }
}
