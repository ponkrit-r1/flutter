// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Next`
  String get nextLabel {
    return Intl.message(
      'Next',
      name: 'nextLabel',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get getStartLabel {
    return Intl.message(
      'Get started',
      name: 'getStartLabel',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skipLabel {
    return Intl.message(
      'Skip',
      name: 'skipLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get orLabel {
    return Intl.message(
      'Or',
      name: 'orLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelLabel',
      desc: '',
      args: [],
    );
  }

  /// `optional`
  String get optionalLabel {
    return Intl.message(
      'optional',
      name: 'optionalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmLabel {
    return Intl.message(
      'Confirm',
      name: 'confirmLabel',
      desc: '',
      args: [],
    );
  }

  /// `Keep your pet healthy`
  String get onboarding1Title {
    return Intl.message(
      'Keep your pet healthy',
      name: 'onboarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Reminders and tracking for your pet's health.`
  String get onboarding1Subtitle {
    return Intl.message(
      'Reminders and tracking for your pet\'s health.',
      name: 'onboarding1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Peace of Mind`
  String get onboarding2Title {
    return Intl.message(
      'Peace of Mind',
      name: 'onboarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Easily locate your furry friend if they wander off.`
  String get onboarding2Subtitle {
    return Intl.message(
      'Easily locate your furry friend if they wander off.',
      name: 'onboarding2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Connect & Save`
  String get onboarding3Title {
    return Intl.message(
      'Connect & Save',
      name: 'onboarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Find pet-friendly places, get discounts, and join a community of pet lovers.`
  String get onboarding3Subtitle {
    return Intl.message(
      'Find pet-friendly places, get discounts, and join a community of pet lovers.',
      name: 'onboarding3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get helloLabel {
    return Intl.message(
      'Hello',
      name: 'helloLabel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcomeLabel {
    return Intl.message(
      'Welcome!',
      name: 'welcomeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Helping you to keep your bestie stay healthy!`
  String get signInDescription {
    return Intl.message(
      'Helping you to keep your bestie stay healthy!',
      name: 'signInDescription',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get loginLabel {
    return Intl.message(
      'Log in',
      name: 'loginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create account with E-mail`
  String get createAccountWithEmail {
    return Intl.message(
      'Create account with E-mail',
      name: 'createAccountWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Create account with`
  String get createAccountWith {
    return Intl.message(
      'Create account with',
      name: 'createAccountWith',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get acceptLabel {
    return Intl.message(
      'Accept',
      name: 'acceptLabel',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termAndCondition {
    return Intl.message(
      'Terms and Conditions',
      name: 'termAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userNameLabel {
    return Intl.message(
      'Username',
      name: 'userNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstNameLabel {
    return Intl.message(
      'First name',
      name: 'firstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastNameLabel {
    return Intl.message(
      'Last name',
      name: 'lastNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `User verification`
  String get userVerificationLabel {
    return Intl.message(
      'User verification',
      name: 'userVerificationLabel',
      desc: '',
      args: [],
    );
  }

  /// `OTP has been sent to `
  String get otpHasBeenSentTo {
    return Intl.message(
      'OTP has been sent to ',
      name: 'otpHasBeenSentTo',
      desc: '',
      args: [],
    );
  }

  /// `please fill in the OTP below`
  String get pleaseFillInTheOtp {
    return Intl.message(
      'please fill in the OTP below',
      name: 'pleaseFillInTheOtp',
      desc: '',
      args: [],
    );
  }

  /// `Resend OTP`
  String get resendOtpLabel {
    return Intl.message(
      'Resend OTP',
      name: 'resendOtpLabel',
      desc: '',
      args: [],
    );
  }

  /// `Continue OTP verification`
  String get continueWithOtpLabel {
    return Intl.message(
      'Continue OTP verification',
      name: 'continueWithOtpLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
