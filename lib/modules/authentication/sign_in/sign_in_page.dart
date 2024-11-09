import 'package:deemmi/core/global_widgets/pettagu_text_field.dart';
import 'package:deemmi/core/global_widgets/primary_style_button.dart';
import 'package:deemmi/core/utils/widget_extension.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_controller.dart';
import 'package:deemmi/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../core/global_widgets/primary_button.dart';
import '../../../core/theme/app_colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _controller = Get.find<SignInController>();

  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  DateTime? currentBackPressTime;

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
        body: WillPopScope(
          onWillPop: onWillPopToastConfirmExit,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${stringRes(context)!.helloLabel},",
                      style: textTheme(context).displayLarge?.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stringRes(context)!.welcomeLabel,
                      style: textTheme(context).headlineLarge?.copyWith(
                            color: AppColor.primary500,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      stringRes(context)!.signInDescription,
                      style: textTheme(context).bodyLarge?.copyWith(
                            color: AppColor.secondaryContentGray,
                          ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ..._emailPasswordAuthentication(context),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
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
        onPressed: () {
          navigateToCreateAccount();
        },
      ),
    );
  }

  _signInWithGoogleButton(BuildContext context) {
    return const SizedBox.shrink();
  }

  _signInWithAppleButton(BuildContext context) {
    return const SizedBox.shrink();
  }

  List<Widget> _emailPasswordAuthentication(BuildContext context) {
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
        height: 10,
      ),
      Row(
        children: [
          Text(
            stringRes(context)!.passwordLabel,
            style: textTheme(context).bodyMedium?.copyWith(
                color: AppColor.textColor, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              navigateToForgotPassword();
            },
            child: Text(
              stringRes(context)!.forgotPassword,
              style: textTheme(context).bodyMedium?.copyWith(
                    color: AppColor.primary500,
                  ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      _passwordForm(context),
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
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.secondary500),
                    ),
                  ),
                )
              : PrimaryButton(
                  title: stringRes(context)!.loginLabel,
                  onPressed: _controller.isInformationCompleted
                      ? () {
                          beginSignIn();
                        }
                      : null,
                  color: AppColor.primary500,
                ),
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      _divider(),
      const SizedBox(
        height: 16,
      ),
      _createAccountWithEmail(),
    ];
  }

  _divider() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: AppColor.borderColor,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          stringRes(context)!.orLabel.toUpperCase(),
          style: textTheme(context)
              .headlineMedium
              ?.copyWith(color: AppColor.secondaryContentGray),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Divider(
            color: AppColor.borderColor,
          ),
        ),
      ],
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

  navigateToForgotPassword() {
    Get.toNamed(Routes.resetPasswordEmail);
  }

  onDisplaySnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _globalKey.currentState?.showSnackBar(snackBar);
  }

  beginSignIn() async {
    try {
      await _controller.signIn();
      navigateToHome();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  navigateToHome() {
    Get.offAllNamed(Routes.root);
  }

  navigateToCreateAccount() {
    Get.toNamed(Routes.createAccount);
  }

  navigateToPolicyWebview() {}

  Future<bool> onWillPopToastConfirmExit() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: stringRes(context)!.pressAgainToExitTheApp,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
