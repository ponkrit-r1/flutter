import 'package:deemmi/modules/authentication/complete/create_account_success_page.dart';
import 'package:deemmi/modules/authentication/register/create_account_binding.dart';
import 'package:deemmi/modules/authentication/register/create_account_page.dart';
import 'package:deemmi/modules/authentication/reset/confirm_password/confirm_password_binding.dart';
import 'package:deemmi/modules/authentication/reset/confirm_password/confirm_password_page.dart';
import 'package:deemmi/modules/authentication/reset/email_to_reset/input_email_reset_password_binding.dart';
import 'package:deemmi/modules/authentication/reset/email_to_reset/input_email_reset_password_page.dart';
import 'package:deemmi/modules/authentication/reset/reset_code/reset_password_verification_binding.dart';
import 'package:deemmi/modules/authentication/reset/reset_code/reset_password_verification_page.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_binding.dart';
import 'package:deemmi/modules/authentication/sign_in/sign_in_page.dart';
import 'package:deemmi/modules/authentication/verification/otp_verification_binding.dart';
import 'package:deemmi/modules/authentication/verification/otp_verification_page.dart';
import 'package:deemmi/modules/notification/notification.dart';
import 'package:deemmi/modules/on_boarding/on_boarding_binding.dart';
import 'package:deemmi/modules/on_boarding/on_boarding_page.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_binding.dart';
import 'package:deemmi/modules/pet/add_pet/add_pet_page.dart';
import 'package:deemmi/modules/pet/clinic/add_pet_clinic_binding.dart';
import 'package:deemmi/modules/pet/clinic/add_pet_clinic_page.dart';
import 'package:deemmi/modules/pet/health_info/pet_health_info_binding.dart';
import 'package:deemmi/modules/pet/health_info/pet_health_info_page.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_binding.dart';
import 'package:deemmi/modules/pet/profile/pet_profile_page.dart';
import 'package:deemmi/modules/routing/restriction/no_connection_page.dart';
import 'package:deemmi/modules/routing/routing_binding.dart';
import 'package:deemmi/modules/routing/routing_page.dart';
import 'package:deemmi/modules/settings/account_setting/account_setting_binding.dart';
import 'package:deemmi/modules/settings/account_setting/account_setting_page.dart';


import 'package:deemmi/modules/settings/update_account/update_email/update_email_page.dart';


import 'package:deemmi/modules/settings/update_account/update_email/update_user_otp.dart';


import 'package:deemmi/modules/settings/update_account/update_username/update_username_page.dart';
import 'package:deemmi/modules/settings/update_account/update_username/update_username_binding.dart';

import 'package:deemmi/modules/settings/update_account/update_name/update_name_page.dart';
import 'package:deemmi/modules/settings/update_account/update_name/update_name_binding.dart';

import 'package:deemmi/modules/settings/update_account/update_password/update_password_page.dart';
import 'package:deemmi/modules/settings/update_account/update_password/update_password_binding.dart';

import 'package:deemmi/modules/pet/pet_tag/add_tag_page.dart';
import 'package:deemmi/modules/pet/pet_tag/existing_tag_page.dart';
import 'package:deemmi/modules/pet/pet_tag/add_tag_detail_qr_page.dart';
import 'package:get/get.dart';

import '../modules/pet/list/pet_list_binding.dart';
import '../modules/root/root_page.dart';
import 'app_routes.dart';

import 'package:deemmi/modules/vaccine/vaccine_program_page.dart';
import 'package:deemmi/modules/vaccine/make_appointment_page.dart';
import 'package:deemmi/modules/vaccine/vaccinated_date_page.dart';

import 'package:deemmi/modules/flea_and_tick/parasite_control_page.dart';
import 'package:deemmi/modules/flea_and_tick/add_pet_protection_page.dart';
import 'package:deemmi/modules/flea_and_tick/edit_pet_protection_page.dart';

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
    ),
    GetPage(
      name: Routes.notification,
      page: () => const NotificationPage(),
    ),
    GetPage(
      name: Routes.account_setting,
      page: () => const AccountSettingPage(),
      bindings: [
        AccountSettingBinding(),
      ],
    ),
    GetPage(
      name: Routes.update_email,
      page: () => UpdateEmailPage(),
    ),
    GetPage(
      name: Routes.update_username,
      page: () => const UpdateUsernamePage(),
      binding: UpdateUsernameBinding(),
    ),
    GetPage(
      name: Routes.update_password,
      page: () => const ChangePasswordPage(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: Routes.update_name,
      page: () => const UpdateNamePage(),
      binding: UpdateNameBinding(),
    ),
    GetPage(
      name: Routes.update_user_otp,
      page: () => const OTPVerificationPage(),
    ),
    GetPage(
      name: Routes.resetPasswordEmail,
      page: () => const InputEmailResetPasswordPage(),
      binding: InputEmailResetPasswordBinding(),
    ),
    GetPage(
      name: Routes.resetPasswordConfirm,
      page: () => const ConfirmPasswordPage(),
      binding: ConfirmPasswordBinding(),
    ),
    GetPage(
      name: Routes.resetPasswordVerification,
      page: () => const ResetPasswordVerificationPage(),
      binding: ResetPasswordVerificationBinding(),
    ),
    GetPage(
      name: Routes.addPetClinic,
      page: () => const AddPetClinicPage(),
      binding: AddPetClinicBinding(),
    ),
    GetPage(
      name: Routes.add_pet_tag,
      page: () => const AddTagPage(),
    ),
    GetPage(
      name: Routes.existing_pet_tag,
      page: () => const ExistingTagPage(),
    ),
    GetPage(
      name: Routes.add_pet_detail_after_qr_tag,
      page: () => const AddTagDetailQrPage(),
    ),
    GetPage(
      name: Routes.vaccine_program,
      page: () =>  VaccineProgramPage(),
    ),
    GetPage(
      name: Routes.make_appointment,
      page: () => MakeAppointmentPage(),
    ),
    GetPage(
      name: Routes.vaccinated_date,
      page: () => VaccinatedDatePage(),
    ),
    GetPage(
      name: Routes.parasite_control,
      page: () => ParasiteControlPage(),
    ),
    GetPage(
      name: Routes.add_pet_protection,
      page: () => AddPetProtectionPage(),
    ),
       GetPage(
      name: Routes.edit_pet_protection,
      page: () => EditPetProtectionPage(),
    ),
  ];
}
