import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';

final ThemeData appThemeData = ThemeData(
  useMaterial3: false,
  primaryColor: AppColor.primary500,
  splashColor: Colors.grey.shade50,
  highlightColor: Colors.grey.shade50,
  textTheme: _textTheme,
  primaryTextTheme: _textTheme,
  appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: _textTheme.labelMedium,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColor.primaryBlack)
      .copyWith(secondary: AppColor.secondary500),
  unselectedWidgetColor: Colors.white,
);

final _textTheme = GoogleFonts.poppinsTextTheme(TextTheme(
  displayLarge: headline1TextStyle,
  displayMedium: headline2TextStyle,
  displaySmall: headline3TextStyleBold,
  headlineLarge: headline4TextStyle,
  headlineMedium: headline5TextStyle,
  headlineSmall: headline6TextStyle,
  titleLarge: subTitleTextStyleBold,
  titleMedium: subTitleTextStyleSmall,
  bodyLarge: bodyTextStyle,
  bodyMedium: bodySmallTextStyle,
  bodySmall: bodyXSmallTextStyle,
  labelLarge: bodyTextStyle.copyWith(color: Colors.white),
)).copyWith(
  // ✅ เพิ่ม NotoSansThai ให้กับฟอนต์หลักของแอป
  bodyLarge: const TextStyle(
    fontFamily: 'NotoSansThai',
    fontWeight: FontWeight.w400, // Regular
    fontSize: 16,
  ),
  bodyMedium: const TextStyle(
    fontFamily: 'NotoSansThai',
    fontWeight: FontWeight.w300, // Light
    fontSize: 14,
  ),
  headlineLarge: const TextStyle(
    fontFamily: 'NotoSansThai',
    fontWeight: FontWeight.w700, // Bold
    fontSize: 32,
  ),
  titleLarge: const TextStyle(
    fontFamily: 'NotoSansThai',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 20,
  ),
);
