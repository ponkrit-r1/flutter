import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/authentication/register/create_account_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/global_widgets/pettagu_text_field.dart';
import '../../../core/global_widgets/primary_button.dart';
import '../../../core/global_widgets/primary_style_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _controller = Get.find<CreateAccountController>();

  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _controller.displayError = onDisplaySnackBar;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: AppColor.secondaryBgColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: stringRes(context)!.createAccountWith,
                      style: textTheme(context).displayLarge?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 36),
                      children: <TextSpan>[
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: stringRes(context)!.emailLabel,
                          style: textTheme(context).displayLarge?.copyWith(
                              color: AppColor.primary500,
                              fontWeight: FontWeight.bold,
                              fontSize: 36),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ...formSections(context),
                  Obx(() =>termAndCondition()),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(
                    () => SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: _controller.isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.secondary500),
                              ),
                            )
                          : PrimaryButton(
                              title: stringRes(context)!.continueWithOtpLabel,
                              onPressed: () {
                                navigateToOtpVerification();
                              },
                              color: AppColor.primary500,
                            ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        stringRes(context)!.cancelLabel,
                        style: textTheme(context)
                            .bodyLarge
                            ?.copyWith(color: AppColor.primary500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _createAccountWithEmail() {
    return SizedBox(
      height: 48,
      child: PrimaryStyleButton(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_outlined,
                color: AppColor.textColor,
              ),
              const SizedBox(width: 8),
              Text(
                stringRes(context)!.createAccountWithEmail,
                style: textTheme(context)
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  _signInWithGoogleButton(BuildContext context) {
    return const SizedBox.shrink();
  }

  _signInWithAppleButton(BuildContext context) {
    return const SizedBox.shrink();
  }

  List<Widget> formSections(BuildContext context) {
    return [
      Text(
        stringRes(context)!.emailLabel,
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(color: AppColor.textColor, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      _emailForm(context),
      const SizedBox(
        height: 16,
      ),
      Text(
        stringRes(context)!.userNameLabel,
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(color: AppColor.textColor, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      _usernameForm(context),
      const SizedBox(
        height: 16,
      ),
      Text(
        stringRes(context)!.passwordLabel,
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(color: AppColor.textColor, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      _passwordForm(context),
      const SizedBox(
        height: 16,
      ),
      Text(
        stringRes(context)!.confirmPasswordLabel,
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(color: AppColor.textColor, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      _confirmPasswordForm(context),
      const SizedBox(
        height: 16,
      ),
      Text(
        stringRes(context)!.firstNameLabel,
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(color: AppColor.textColor, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      _firstnameForm(context),
      const SizedBox(
        height: 16,
      ),
      Text(
        stringRes(context)!.lastNameLabel,
        style: textTheme(context)
            .bodyMedium
            ?.copyWith(color: AppColor.textColor, fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 10,
      ),
      _lastnameForm(context),
    ];
  }

  termAndCondition() {
    return InkWell(
      onTap: () {
        _controller.setTermAccept(!_controller.isTermAccepted);
      },
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text.rich(
          TextSpan(
            text: stringRes(context)!.acceptLabel,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColor.textColor),
            children: [
              TextSpan(
                text: ' ${stringRes(context)!.termAndCondition}',
                style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColor.primary500),
              )
            ],
          ),
        ),
        value: _controller.isTermAccepted,
        onChanged: null,
        selectedTileColor: AppColor.primary500,
        checkColor: AppColor.primary500,
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  _emailForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.emailAddress,
      controller: _controller.emailController,
      fillColor: Colors.white,
    );
  }

  _passwordForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: _controller.passwordController,
      fillColor: Colors.white,
    );
  }

  _confirmPasswordForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: _controller.confirmPasswordController,
      fillColor: Colors.white,
    );
  }

  _usernameForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      controller: _controller.userNameController,
      fillColor: Colors.white,
    );
  }

  _firstnameForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      controller: _controller.firstNameController,
      fillColor: Colors.white,
    );
  }

  _lastnameForm(BuildContext context) {
    return PettaguTextField(
      hintText: "",
      keyboardType: TextInputType.visiblePassword,
      controller: _controller.lastNameController,
      fillColor: Colors.white,
    );
  }

  showForgotPasswordDialog(BuildContext context) {}

  onDisplaySnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _globalKey.currentState?.showSnackBar(snackBar);
  }

  navigateToOtpVerification() {
    Get.toNamed(Routes.otpVerification);
  }

  navigateToPolicyWebview() {}
}
