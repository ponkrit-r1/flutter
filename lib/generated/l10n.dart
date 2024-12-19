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

  /// `General settings`
  String get general {
    return Intl.message(
      'General settings',
      name: 'general',
      desc: 'Contains general settings labels',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Change-Password`
  String get change_password {
    return Intl.message(
      'Change-Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Thai`
  String get th {
    return Intl.message(
      'Thai',
      name: 'th',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message(
      'English',
      name: 'en',
      desc: '',
      args: [],
    );
  }

  /// `My pets`
  String get mypet {
    return Intl.message(
      'My pets',
      name: 'mypet',
      desc: '',
      args: [],
    );
  }

  /// `การแจ้งเตือน`
  String get notification {
    return Intl.message(
      'การแจ้งเตือน',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Articles`
  String get article {
    return Intl.message(
      'Articles',
      name: 'article',
      desc: '',
      args: [],
    );
  }

  /// `Shop nows`
  String get shopnow {
    return Intl.message(
      'Shop nows',
      name: 'shopnow',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Animal Care`
  String get animalcare {
    return Intl.message(
      'Animal Care',
      name: 'animalcare',
      desc: '',
      args: [],
    );
  }

  /// `Microchip ID`
  String get microchip {
    return Intl.message(
      'Microchip ID',
      name: 'microchip',
      desc: '',
      args: [],
    );
  }

  /// `ลักษณะพิเศษ`
  String get specialcharacteristic {
    return Intl.message(
      'ลักษณะพิเศษ',
      name: 'specialcharacteristic',
      desc: '',
      args: [],
    );
  }

  /// `ข้อมูล สุขภาพ`
  String get healthinfo {
    return Intl.message(
      'ข้อมูล สุขภาพ',
      name: 'healthinfo',
      desc: '',
      args: [],
    );
  }

  /// `ข้อมูล คลีนิค`
  String get clinicinfo {
    return Intl.message(
      'ข้อมูล คลีนิค',
      name: 'clinicinfo',
      desc: '',
      args: [],
    );
  }

  /// `Sterilization`
  String get sterilization {
    return Intl.message(
      'Sterilization',
      name: 'sterilization',
      desc: '',
      args: [],
    );
  }

  /// `Chronic Disease`
  String get chronicdisease {
    return Intl.message(
      'Chronic Disease',
      name: 'chronicdisease',
      desc: '',
      args: [],
    );
  }

  /// `Food Allergy`
  String get foodallergy {
    return Intl.message(
      'Food Allergy',
      name: 'foodallergy',
      desc: '',
      args: [],
    );
  }

  /// `Vaccine Allergy`
  String get vaccineallergy {
    return Intl.message(
      'Vaccine Allergy',
      name: 'vaccineallergy',
      desc: '',
      args: [],
    );
  }

  /// `Drug Allergy`
  String get drugallergy {
    return Intl.message(
      'Drug Allergy',
      name: 'drugallergy',
      desc: '',
      args: [],
    );
  }

  /// `เพิ่มสัตว์เลี้ยง`
  String get addpetinfo {
    return Intl.message(
      'เพิ่มสัตว์เลี้ยง',
      name: 'addpetinfo',
      desc: '',
      args: [],
    );
  }

  /// `Add your pet photo`
  String get addyourpetphoto {
    return Intl.message(
      'Add your pet photo',
      name: 'addyourpetphoto',
      desc: '',
      args: [],
    );
  }

  /// `Maximum File Size`
  String get maximumsize {
    return Intl.message(
      'Maximum File Size',
      name: 'maximumsize',
      desc: '',
      args: [],
    );
  }

  /// `Pet Type`
  String get pettype {
    return Intl.message(
      'Pet Type',
      name: 'pettype',
      desc: '',
      args: [],
    );
  }

  /// `Pet Name`
  String get petname {
    return Intl.message(
      'Pet Name',
      name: 'petname',
      desc: '',
      args: [],
    );
  }

  /// `Microchip ID`
  String get microchipid {
    return Intl.message(
      'Microchip ID',
      name: 'microchipid',
      desc: '',
      args: [],
    );
  }

  /// `(Optional)`
  String get optional {
    return Intl.message(
      '(Optional)',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Breed`
  String get breed {
    return Intl.message(
      'Breed',
      name: 'breed',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Don't know`
  String get donotknow {
    return Intl.message(
      'Don\'t know',
      name: 'donotknow',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dob {
    return Intl.message(
      'Date of Birth',
      name: 'dob',
      desc: '',
      args: [],
    );
  }

  /// `Animal Care System`
  String get animalcaresystem {
    return Intl.message(
      'Animal Care System',
      name: 'animalcaresystem',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Maybe Later`
  String get maybelater {
    return Intl.message(
      'Maybe Later',
      name: 'maybelater',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
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

  /// `browse`
  String get browseLabel {
    return Intl.message(
      'browse',
      name: 'browseLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get selectLabel {
    return Intl.message(
      'Select',
      name: 'selectLabel',
      desc: '',
      args: [],
    );
  }

  /// `Network error`
  String get networkErrorMessage {
    return Intl.message(
      'Network error',
      name: 'networkErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownErrorMessage {
    return Intl.message(
      'Unknown error',
      name: 'unknownErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Press again to exit the app`
  String get pressAgainToExitTheApp {
    return Intl.message(
      'Press again to exit the app',
      name: 'pressAgainToExitTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitLabel {
    return Intl.message(
      'Submit',
      name: 'submitLabel',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been updated`
  String get passwordUpdatedLabel {
    return Intl.message(
      'Your password has been updated',
      name: 'passwordUpdatedLabel',
      desc: '',
      args: [],
    );
  }

  /// `You can now login with a new password`
  String get loginWithNewPassword {
    return Intl.message(
      'You can now login with a new password',
      name: 'loginWithNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeLabel {
    return Intl.message(
      'Close',
      name: 'closeLabel',
      desc: '',
      args: [],
    );
  }

  /// `onboarding`
  String get onboarding {
    return Intl.message(
      'onboarding',
      name: 'onboarding',
      desc: 'Contains general settings labels',
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

  /// `Sign_in`
  String get signin {
    return Intl.message(
      'Sign_in',
      name: 'signin',
      desc: 'Contains general settings labels',
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

  /// `Create account with Email`
  String get createAccountWithEmail {
    return Intl.message(
      'Create account with Email',
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

  /// `Invalid email`
  String get invalidEmailLabel {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters long\n1 lowercase character (a-z)\n1 uppercase character (A-Z)\n1 number\nAt least 1 special character`
  String get invalidPasswordLabel {
    return Intl.message(
      'At least 8 characters long\n1 lowercase character (a-z)\n1 uppercase character (A-Z)\n1 number\nAt least 1 special character',
      name: 'invalidPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password not match`
  String get passwordNotMatch {
    return Intl.message(
      'Password not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mollis vulputate est, id lacinia ligula sodales vitae. Sed eget nibh libero. Vivamus porttitor non lorem eu iaculis. Maecenas ultricies vel dui et aliquet. Curabitur molestie ante arcu, in facilisis mauris rutrum eget. Nam neque odio, tincidunt sed dapibus at, faucibus quis ante. Nullam luctus scelerisque ex quis sollicitudin. Ut mattis tristique nibh, et porttitor ipsum eleifend eget. In ac est rutrum, molestie mi nec, convallis lectus. Etiam molestie felis vel leo lobortis, nec tempus nibh imperdiet. Integer et euismod purus, ut posuere nibh. Ut neque dui, iaculis id semper at, consequat vitae sem. Aliquam rutrum ac erat in congue.\n\nAliquam a maximus augue. Maecenas mattis efficitur sem, nec elementum quam scelerisque mollis. Quisque eu volutpat dui. Etiam facilisis sem at ex convallis, ac finibus ante rutrum. Curabitur ultricies tellus dictum nulla tempor, quis vestibulum nibh dignissim. Vestibulum semper semper mi, eleifend auctor urna mollis at. Aliquam at dolor arcu. Maecenas eleifend nulla eu nunc cursus scelerisque. Sed commodo rhoncus congue. Pellentesque tempus ultricies turpis, at placerat nibh venenatis eget. Sed viverra euismod magna quis volutpat. Praesent bibendum dui purus, sit amet gravida eros finibus eu. Cras lobortis luctus ipsum.\n\nPhasellus mollis blandit nunc eget laoreet. Proin facilisis quam vitae leo aliquet sagittis. Nam at mollis lorem. Sed ac ligula iaculis, hendrerit risus quis, pellentesque mauris. Mauris viverra accumsan eleifend. Phasellus ac faucibus nulla, ut fermentum tortor. Vivamus sed neque non felis tempor venenatis. Nulla facilisi. Duis sed commodo mauris. Suspendisse finibus, lacus et dictum tristique, nisi mauris venenatis nulla, sed varius libero massa vitae mauris. Cras nec tellus sit amet lorem porttitor eleifend ac eu leo. In lacinia, ex sed ullamcorper iaculis, risus diam dapibus dui, et semper justo quam eget erat.\n\nPhasellus feugiat, urna id aliquam malesuada, est lorem vehicula nisi, a semper felis felis et justo. Donec vitae mauris nisl. Suspendisse gravida varius lacus, a congue leo efficitur non. Proin vel quam mi. Nam finibus felis odio, quis pulvinar ex ornare eu. Aliquam pellentesque nec leo id tincidunt. Vivamus at blandit leo, porttitor cursus ligula. Curabitur vel augue neque. Nulla fringilla consequat lacus ut porta. Aliquam ut libero vitae nunc dignissim fringilla. Aliquam erat volutpat. Vivamus maximus sodales nisl, ac facilisis lorem convallis vitae. Duis erat dolor, maximus sit amet blandit nec, tincidunt a quam.\n\nSed lacinia vel odio sit amet tristique. Aliquam ut nisl augue. Aliquam vel nibh sapien. Vivamus interdum nibh risus, non pellentesque justo aliquam quis. Duis bibendum lorem in nulla iaculis lacinia. Quisque id ante id nisl consequat condimentum. Cras accumsan facilisis lectus, eget rutrum eros eleifend a. Sed nibh nisi, auctor iaculis leo a, rutrum consequat nisl.`
  String get placeHolderTermAndCondition {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec mollis vulputate est, id lacinia ligula sodales vitae. Sed eget nibh libero. Vivamus porttitor non lorem eu iaculis. Maecenas ultricies vel dui et aliquet. Curabitur molestie ante arcu, in facilisis mauris rutrum eget. Nam neque odio, tincidunt sed dapibus at, faucibus quis ante. Nullam luctus scelerisque ex quis sollicitudin. Ut mattis tristique nibh, et porttitor ipsum eleifend eget. In ac est rutrum, molestie mi nec, convallis lectus. Etiam molestie felis vel leo lobortis, nec tempus nibh imperdiet. Integer et euismod purus, ut posuere nibh. Ut neque dui, iaculis id semper at, consequat vitae sem. Aliquam rutrum ac erat in congue.\n\nAliquam a maximus augue. Maecenas mattis efficitur sem, nec elementum quam scelerisque mollis. Quisque eu volutpat dui. Etiam facilisis sem at ex convallis, ac finibus ante rutrum. Curabitur ultricies tellus dictum nulla tempor, quis vestibulum nibh dignissim. Vestibulum semper semper mi, eleifend auctor urna mollis at. Aliquam at dolor arcu. Maecenas eleifend nulla eu nunc cursus scelerisque. Sed commodo rhoncus congue. Pellentesque tempus ultricies turpis, at placerat nibh venenatis eget. Sed viverra euismod magna quis volutpat. Praesent bibendum dui purus, sit amet gravida eros finibus eu. Cras lobortis luctus ipsum.\n\nPhasellus mollis blandit nunc eget laoreet. Proin facilisis quam vitae leo aliquet sagittis. Nam at mollis lorem. Sed ac ligula iaculis, hendrerit risus quis, pellentesque mauris. Mauris viverra accumsan eleifend. Phasellus ac faucibus nulla, ut fermentum tortor. Vivamus sed neque non felis tempor venenatis. Nulla facilisi. Duis sed commodo mauris. Suspendisse finibus, lacus et dictum tristique, nisi mauris venenatis nulla, sed varius libero massa vitae mauris. Cras nec tellus sit amet lorem porttitor eleifend ac eu leo. In lacinia, ex sed ullamcorper iaculis, risus diam dapibus dui, et semper justo quam eget erat.\n\nPhasellus feugiat, urna id aliquam malesuada, est lorem vehicula nisi, a semper felis felis et justo. Donec vitae mauris nisl. Suspendisse gravida varius lacus, a congue leo efficitur non. Proin vel quam mi. Nam finibus felis odio, quis pulvinar ex ornare eu. Aliquam pellentesque nec leo id tincidunt. Vivamus at blandit leo, porttitor cursus ligula. Curabitur vel augue neque. Nulla fringilla consequat lacus ut porta. Aliquam ut libero vitae nunc dignissim fringilla. Aliquam erat volutpat. Vivamus maximus sodales nisl, ac facilisis lorem convallis vitae. Duis erat dolor, maximus sit amet blandit nec, tincidunt a quam.\n\nSed lacinia vel odio sit amet tristique. Aliquam ut nisl augue. Aliquam vel nibh sapien. Vivamus interdum nibh risus, non pellentesque justo aliquam quis. Duis bibendum lorem in nulla iaculis lacinia. Quisque id ante id nisl consequat condimentum. Cras accumsan facilisis lectus, eget rutrum eros eleifend a. Sed nibh nisi, auctor iaculis leo a, rutrum consequat nisl.',
      name: 'placeHolderTermAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `Scroll down to agree`
  String get scrollToBottomLabel {
    return Intl.message(
      'Scroll down to agree',
      name: 'scrollToBottomLabel',
      desc: '',
      args: [],
    );
  }

  /// `I Agree`
  String get iAgreeLabel {
    return Intl.message(
      'I Agree',
      name: 'iAgreeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create new password`
  String get createNewPasswordLabel {
    return Intl.message(
      'Create new password',
      name: 'createNewPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPasswordLabel {
    return Intl.message(
      'New password',
      name: 'newPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `add pet`
  String get addpet {
    return Intl.message(
      'add pet',
      name: 'addpet',
      desc: 'Contains general settings labels',
      args: [],
    );
  }

  /// `Add pet info`
  String get addPetInfoLabel {
    return Intl.message(
      'Add pet info',
      name: 'addPetInfoLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add your pet photo`
  String get addYourPetPhoto {
    return Intl.message(
      'Add your pet photo',
      name: 'addYourPetPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Maximum size: 5MB`
  String get maximumSizeLabel {
    return Intl.message(
      'Maximum size: 5MB',
      name: 'maximumSizeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pet type`
  String get petTypeLabel {
    return Intl.message(
      'Pet type',
      name: 'petTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dog`
  String get dogLabel {
    return Intl.message(
      'Dog',
      name: 'dogLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cat`
  String get catLabel {
    return Intl.message(
      'Cat',
      name: 'catLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pet name`
  String get petNameLabel {
    return Intl.message(
      'Pet name',
      name: 'petNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Microchip ID `
  String get microchipIdLabel {
    return Intl.message(
      'Microchip ID ',
      name: 'microchipIdLabel',
      desc: '',
      args: [],
    );
  }

  /// `Breed`
  String get breedLabel {
    return Intl.message(
      'Breed',
      name: 'breedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genderLabel {
    return Intl.message(
      'Gender',
      name: 'genderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get maleLabel {
    return Intl.message(
      'Male',
      name: 'maleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get femaleLabel {
    return Intl.message(
      'Female',
      name: 'femaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Don't know`
  String get dontKnowLabel {
    return Intl.message(
      'Don\'t know',
      name: 'dontKnowLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dateOfBirthLabel {
    return Intl.message(
      'Date of birth',
      name: 'dateOfBirthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select date of birth`
  String get selectDateOfBirthLabel {
    return Intl.message(
      'Select date of birth',
      name: 'selectDateOfBirthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get ageLabel {
    return Intl.message(
      'Age',
      name: 'ageLabel',
      desc: '',
      args: [],
    );
  }

  /// `months`
  String get monthsLabel {
    return Intl.message(
      'months',
      name: 'monthsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Weight `
  String get weightLabel {
    return Intl.message(
      'Weight ',
      name: 'weightLabel',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get kgLabel {
    return Intl.message(
      'kg',
      name: 'kgLabel',
      desc: '',
      args: [],
    );
  }

  /// `Animal care system `
  String get animalCareSystemLabel {
    return Intl.message(
      'Animal care system ',
      name: 'animalCareSystemLabel',
      desc: '',
      args: [],
    );
  }

  /// `Indoor`
  String get indoorLabel {
    return Intl.message(
      'Indoor',
      name: 'indoorLabel',
      desc: '',
      args: [],
    );
  }

  /// `Outdoor`
  String get outdoorLabel {
    return Intl.message(
      'Outdoor',
      name: 'outdoorLabel',
      desc: '',
      args: [],
    );
  }

  /// `Special characteristics `
  String get specialCharacteristicsLabel {
    return Intl.message(
      'Special characteristics ',
      name: 'specialCharacteristicsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Maybe later`
  String get maybeLaterLabel {
    return Intl.message(
      'Maybe later',
      name: 'maybeLaterLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select month`
  String get selectMonthLabel {
    return Intl.message(
      'Select month',
      name: 'selectMonthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select year`
  String get selectYearLabel {
    return Intl.message(
      'Select year',
      name: 'selectYearLabel',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get doneLabel {
    return Intl.message(
      'Done',
      name: 'doneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteLabel {
    return Intl.message(
      'Delete',
      name: 'deleteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit pet`
  String get editPetLabel {
    return Intl.message(
      'Edit pet',
      name: 'editPetLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get saveLabel {
    return Intl.message(
      'Save',
      name: 'saveLabel',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get comingSoonLabel {
    return Intl.message(
      'Coming Soon',
      name: 'comingSoonLabel',
      desc: '',
      args: [],
    );
  }

  /// `add pet health`
  String get add_pet_health {
    return Intl.message(
      'add pet health',
      name: 'add_pet_health',
      desc: 'Contains general settings labels',
      args: [],
    );
  }

  /// `Add pet health`
  String get addPetHealthLabel {
    return Intl.message(
      'Add pet health',
      name: 'addPetHealthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit pet health`
  String get editPetHealthLabel {
    return Intl.message(
      'Edit pet health',
      name: 'editPetHealthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sterilization`
  String get sterilizationLabel {
    return Intl.message(
      'Sterilization',
      name: 'sterilizationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yesLabel {
    return Intl.message(
      'Yes',
      name: 'yesLabel',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get noLabel {
    return Intl.message(
      'No',
      name: 'noLabel',
      desc: '',
      args: [],
    );
  }

  /// `Chronic disease`
  String get chronicDiseaseLabel {
    return Intl.message(
      'Chronic disease',
      name: 'chronicDiseaseLabel',
      desc: '',
      args: [],
    );
  }

  /// `Food allergy`
  String get foodAllergyLabel {
    return Intl.message(
      'Food allergy',
      name: 'foodAllergyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Vaccine allergy`
  String get vaccineAllergyLabel {
    return Intl.message(
      'Vaccine allergy',
      name: 'vaccineAllergyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Drug allergy`
  String get drugAllergyLabel {
    return Intl.message(
      'Drug allergy',
      name: 'drugAllergyLabel',
      desc: '',
      args: [],
    );
  }

  /// `root`
  String get root {
    return Intl.message(
      'root',
      name: 'root',
      desc: 'Contains general settings labels',
      args: [],
    );
  }

  /// `Home`
  String get homeLabel {
    return Intl.message(
      'Home',
      name: 'homeLabel',
      desc: '',
      args: [],
    );
  }

  /// `My pet`
  String get myPetLabel {
    return Intl.message(
      'My pet',
      name: 'myPetLabel',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get exploreLabel {
    return Intl.message(
      'Explore',
      name: 'exploreLabel',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get communityLabel {
    return Intl.message(
      'Community',
      name: 'communityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPasswordLabel {
    return Intl.message(
      'Reset password',
      name: 'resetPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `We will send reset code to your e-mail`
  String get resetPasswordDescription {
    return Intl.message(
      'We will send reset code to your e-mail',
      name: 'resetPasswordDescription',
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
      Locale.fromSubtags(languageCode: 'th'),
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
