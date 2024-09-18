import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/auth/user_model.dart';

const _latestAcceptedAppTermAndConditionVersion =
    'latestAcceptedAppTermAndConditionId';
const _userKey = 'userKey';
const _userSessionKey = 'userSessionKey';
const _cartTokenKey = 'cartTokenKey';
const _isFirstInstallKey = 'isFirstInstallKey';
const _isNotificationEnable = 'isNotificationEnabled';
const _latestOutdatedAddressDialogShown = 'latestOutdatedAddressDialogShown';
const _userLanguage = 'userLanguage';

class AppStorage {
  // static final AppStorage shared = AppStorage._internal();
  static final AppStorage shared = AppStorage._internal();
  final FlutterSecureStorage _storage;

  late SharedPreferences _prefs;

  AppStorage(
      {required FlutterSecureStorage storage, required SharedPreferences prefs})
      : _storage = storage,
        _prefs = prefs;

  AppStorage._internal() : _storage = const FlutterSecureStorage();

  String? get latestAcceptedAppTermAndConditionVersion {
    return _prefs.getString(_latestAcceptedAppTermAndConditionVersion);
  }

  set latestAcceptedAppTermAndConditionVersion(
      String? latestAcceptedAppTermAndConditionId) {
    if (latestAcceptedAppTermAndConditionId != null) {
      _prefs.setString(_latestAcceptedAppTermAndConditionVersion,
          latestAcceptedAppTermAndConditionId);
    } else {
      _prefs.remove(_latestAcceptedAppTermAndConditionVersion);
    }
  }

  Future<bool> get isSignedIn async {
    final currentSession = await getUserSession();
    final currentUser = getUser;

    return (currentSession != null && currentUser != null);
  }

  Future<String?> get refreshToken async {
    final currentSession = await getUserSession();
    return currentSession;
  }

  Future<void> logout() async {
    await setUserSession(null);
    await setUser(null);
    await setCartToken(null);
    // await setMustConnectAccountWithSCGId(null);
  }

  /// Must call this to initialize late properties.
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool isFirstInstall() {
    final isFirstInstall = _prefs.getBool(_isFirstInstallKey);
    if (isFirstInstall != null) {
      return isFirstInstall;
    } else {
      return true;
    }
  }

  Future<void> setFirstInstall(bool? isFirstInstall) {
    if (isFirstInstall != null) {
      return _prefs.setBool(
        _isFirstInstallKey,
        isFirstInstall,
      );
    } else {
      return _prefs.remove(_isFirstInstallKey);
    }
  }

  Future<void> setUserSession(String? userSession) async {
    if (userSession != null) {
      _storage.write(
        key: _userSessionKey,
        value: userSession,
      );
    } else {
      _storage.delete(key: _userSessionKey);
    }
  }

  Future<String?> getUserSession() async {
    final userSessionData = await _storage.read(key: _userSessionKey);
    if (userSessionData != null) {
      return userSessionData;
    } else {
      return null;
    }
  }

  // User
  User? get getUser {
    final userString = _prefs.getString(_userKey);
    if (userString != null) {
      try {
        final userMap = jsonDecode(userString);
        return User.fromJson(userMap);
      } catch (error) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> setUser(User? user) {
    if (user != null) {
      String userString = jsonEncode(user.toJson());
      return _prefs.setString(_userKey, userString);
    } else {
      return _prefs.remove(_userKey);
    }
  }

  Future<void> setCartToken(String? cartToken) {
    if (cartToken != null) {
      return _prefs.setString(
        _cartTokenKey,
        cartToken,
      );
    } else {
      return _prefs.remove(_cartTokenKey);
    }
  }

  String? getCartToken() {
    final cartToken = _prefs.getString(_cartTokenKey);
    if (cartToken != null) {
      return cartToken;
    } else {
      return null;
    }
  }

  bool isNotificationEnabled() {
    return _prefs.getBool(_isNotificationEnable) ?? true;
  }

  setNotificationEnable(bool isEnable) {
    _prefs.setBool(_isNotificationEnable, isEnable);
  }

  setUserLanguage(String languageCode) async {
    await _prefs.setString(_userLanguage, languageCode);
  }

  // SupportedLocale? getUserLanguage() {
  //   var lang = _prefs.getString(_userLanguage);
  //   return lang != null ? SupportedLocale.fromValue(lang) : null;
  // }

  DateTime? getLatestOutdatedAddressDialogShown() {
    var timeStamp = _prefs.getInt(_latestOutdatedAddressDialogShown);
    return timeStamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timeStamp)
        : null;
  }

  Future<void> setLatestOutdatedAddressDialogShown(DateTime dateTime) async {
    var timeStamp = dateTime.millisecondsSinceEpoch;
    await _prefs.setInt(_latestOutdatedAddressDialogShown, timeStamp);
  }
}
