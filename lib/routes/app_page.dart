import 'package:deemmi/modules/authentication/register/create_account_binding.dart';
import 'package:deemmi/modules/authentication/register/create_account_page.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_binding.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_controller.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_page.dart';
import 'package:deemmi/modules/authentication/verification/otp_verification_binding.dart';
import 'package:deemmi/modules/authentication/verification/otp_verification_page.dart';
import 'package:deemmi/modules/on_boarding/on_boarding_binding.dart';
import 'package:deemmi/modules/on_boarding/on_boarding_page.dart';
import 'package:deemmi/modules/routing/routing_binding.dart';
import 'package:deemmi/modules/routing/routing_controller.dart';
import 'package:deemmi/modules/routing/routing_page.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    // GetPage(name: Routes.root, page: () => const RootPage(), bindings: [
    //   DashboardBinding(),
    //   MyPlanBinding(),
    //   PrePostureBinding(),
    //   SettingBinding(),
    //   ActivityCalendarBinding(),
    // ]),

    GetPage(
      name: Routes.routing,
      page: () => const RoutingPage(),
      binding: RoutingBinding(),
    ),

    GetPage(
      name: Routes.onboarding,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
    ),

    GetPage(
      name: Routes.signIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.createAccount,
      page: () => const CreateAccountPage(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: Routes.otpVerification,
      page: () => const OtpVerificationPage(),
      binding: OtpVerificationBinding(),
    ),
  ];
}
