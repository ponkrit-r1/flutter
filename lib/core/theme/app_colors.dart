import 'package:flutter/material.dart';

abstract class AppColor {
  static const primary500 = Color(0xff2563EB);
  static const primaryLight = Color(0xffDAEBF3);

  static const secondary500 = Color(0xff00D797);

  static const secondaryBgColor = Color(0xffF8FAFC);
  static const brandYellow = Color(0xffE7B569);

  static const base100 = Color(0xffF2F2F2);
  static const base200 = Color(0xffF8F8F8);
  static const base300 = Color(0xffF8FCFD);

  static const premiumYellow = Color(0xffF8E2AC);
  static const premiumYellowText = Color(0xffEBBD63);
  static var premiumYellowBg = premiumYellowText.withAlpha(60);

  static const dark500 = Color(0xff161616);

  static const redError = Color(0xffEF4444);
  static const notificationRed = Color(0xffEA4C46);
  static const yellowWarning = Color(0xffF4BF59);
  static const green = Color(0xff00D797);
  static const greenNormal = Color(0xff89C596);
  static const orangeWarningProgress = Color(0xffED820E);

  static const textColor = Color(0xff1F2937);
  static const secondaryContentGray = Color(0xff6B7280);
  static const formTextColor = Color(0xff9CA3AF);
  static const disableColor = Color(0xffF3F4F6);
  static const borderColor = Color(0xffE5E7EB);

  static const MaterialColor primaryBlack = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_blackPrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const int _blackPrimaryValue = 0xFF000000;
}
