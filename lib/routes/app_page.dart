import 'package:deemmi/modules/authentication/complete/create_account_success_page.dart';
import 'package:deemmi/modules/authentication/register/create_account_binding.dart';
import 'package:deemmi/modules/authentication/register/create_account_page.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_binding.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_page.dart';
import 'package:deemmi/modules/authentication/verification/otp_verification_binding.dart';
import 'package:deemmi/modules/authentication/verification/otp_verification_page.dart';
import 'package:deemmi/modules/on_boarding/on_boarding_binding.dart';
import 'package:deemmi/modules/on_boarding/on_boarding_page.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_binding.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_page.dart';
import 'package:deemmi/modules/pet/health_info/pet_health_info_binding.dart';
import 'package:deemmi/modules/pet/health_info/pet_health_info_page.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_binding.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_page.dart';
import 'package:deemmi/modules/routing/restriction/no_connection_page.dart';
import 'package:deemmi/modules/routing/routing_binding.dart';
import 'package:deemmi/modules/routing/routing_page.dart';
import 'package:get/get.dart';

import '../modules/pet/list/pet_list_binding.dart';
import '../modules/root/root_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.root,
      page: () => const RootPage(),
      bindings: [
        PetListBinding(),
      ],
    ),
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
    GetPage(
      name: Routes.createAccountSuccess,
      page: () => const CreateAccountSuccessPage(),
    ),
    GetPage(
      name: Routes.addPet,
      page: () => const AddPetPage(),
      binding: AddPetBinding(),
    ),
    GetPage(
      name: Routes.petProfile,
      page: () => PetProfilePage(),
      binding: PetProfileBinding(),
    ),
    GetPage(
      name: Routes.noConnection,
      page: () => NoConnectionPage(),
    ),
    GetPage(
      name: Routes.healthInfo,
      page: () => const PetHealthInfoPage(),
      binding: PetHealthInfoBinding(),
    )
  ];
}
