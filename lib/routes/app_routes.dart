abstract class Routes {
  static const initialPage = routing;
  static const signIn = '/signIn';
  static const createAccount = '/create_account';
  static const otpVerification = '/otp_verification';
  static const addPet = '/add_pet';
  static const healthInfo = '/health_info';
  static const webView = '/web_view';
  static const routing = '/routing';
  static const root = '/root';
  static const onboarding = '/on_boarding';
  static const createAccountSuccess = '/create_account_success';
  static const petProfile = '/pet_profile';
  static const notification = '/notification';
  static const account_setting = '/account_setting';
  static const update_email = '/update_email';
  static const update_username = '/update_username';
  static const update_password = '/update_password';
  static const update_name = '/update_name';
  static const update_user_otp = '/update_user_otp';

  //Restriction
  static const noConnection = '/noConnection';
  static const forceUpdate = '/forceUpdate';
  static const maintenance = '/maintenance';
}

abstract class RouteParams {
  static const userEmail = 'user_email';
  static const userId = 'user_id';
  static const userName = 'username';
  static const password = 'password';
  static const petModel = 'pet_model';
}

abstract class RouteAction {
  static const refresh = 'refresh';
}
