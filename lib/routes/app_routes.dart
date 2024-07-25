abstract class Routes {
  static const initialPage = routing;
  static const signIn = '/signIn';
  static const createAccount = '/create_account';
  static const otpVerification = '/otp_verification';
  static const addPet = '/stretch_page';
  static const webView = '/web_view';
  static const routing = '/routing';
  static const root = '/root';
  static const onboarding = '/on_boarding';

  //Restriction
  static const noConnection = '/noConnection';
  static const forceUpdate = '/forceUpdate';
  static const maintenance = '/maintenance';
}

abstract class RouteParams {}

abstract class RouteAction {
  static const refresh = 'refresh';
}
