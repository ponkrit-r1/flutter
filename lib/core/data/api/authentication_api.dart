import 'package:deemmi/core/domain/auth/term_data.dart';

import '../../domain/auth/create_account_request.dart';
import '../../domain/auth/user_model.dart';
import '../../domain/user_session.dart';
import '../../network/api_client.dart';
import '../app_storage.dart';

class AuthenticationAPI {
  final ApiClient apiClient;
  final AppStorage appStorage;

  AuthenticationAPI(this.apiClient, this.appStorage);

  Future<User> userProfile() async {
    var response = await apiClient.getHTTP(
      '/api/v2/storefront/account',
    );

    final user = User.fromJson(response.data);

    return user;
  }

  Future<User> refreshUserProfile() async {
    return _fetchUserProfile();
  }

  // Fetch and save user profile to local storage.
  Future<User> _fetchUserProfile() async {
    final user = await userProfile();
    await appStorage.setUser(user);
    // appStorage.refresh();

    return user;
  }

  Future<TermData> getLatestConditionFile() async {
    var response = await apiClient.getHTTP('/user-condition/condition_file');
    print("--------->           term <---------"+response.toString());
    return TermData.fromJson(response.data);
  }

  Future<User> register(CreateAccountModel model) async {
    var response = await apiClient.postHTTP('/signup/', model.toJson());
    return User.fromJson(response.data);
  }

  Future<void> updateAccount({
    required dynamic model,
  }) async {
    await apiClient.putHTTP('/api/v1/services/accounts', {});

    await _fetchUserProfile();

    return;
  }

  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    final params = {
      "data": {
        "type": "user",
        "attributes": {
          "old_password": oldPassword,
          "new_password": newPassword,
          "password_confirmation": newPassword
        }
      }
    };

    await apiClient.putHTTP(
      '/api/v1/services/accounts',
      params,
    );

    return;
  }

  Future<void> signOut({required String accessToken}) async {
    final params = {
      'token': accessToken,
    };

    var response = await apiClient.postHTTP(
      '/spree_oauth/revoke',
      params,
    );

    await appStorage.logout();
  }

  Future<UserSession> signIn(String username, String password) async {
    final params = {
      "username": username,
      "password": password,
    };

    var response = await apiClient.postHTTP(
      '/login/',
      params,
    );
    var userSession = UserSession.fromJson(response.data);
    await appStorage.setUserSession(userSession);
    return userSession;
  }

  Future<dynamic> requestOtp(int userId, String email) async {
    Map<String, dynamic> request = <String, dynamic>{
      'id': userId,
      'email': email,
    };

    var response = await apiClient.postHTTP(
      '/user-reset-otp/',
      request,
    );

    return response.data;
  }

  Future<dynamic> verifyResetEmail(
    String email,
    String code,
  ) async {
    Map<String, dynamic> params = {
      'email': email,
      'otp': code,
    };

    // await apiClient.postHTTP(
    //   "/verify/",
    //   params,
    // );
  }

  Future<dynamic> verifyOtp(
    String email,
    String code,
  ) async {
    Map<String, dynamic> params = {
      'email': email,
      'otp': code,
    };

    await apiClient.postHTTP(
      "/verify/",
      params,
    );
  }

  Future<dynamic> resetPasswordOTP(
    String email,
  ) async {
    Map<String, dynamic> params = {
      'email': email,
    };

    await apiClient.postHTTP(
      "/user-reset-otp/",
      params,
    );
  }

  Future<dynamic> verifyResetOtp(
    String email,
    String otp,
  ) async {
    Map<String, dynamic> params = {
      "email": email,
      "otp": otp,
    };

    var response = await apiClient.postHTTP(
      "/verify/",
      params,
    );

    var session = UserSession.fromJson(response.data);
    await appStorage.setUserSession(session);
    return session;
  }

  Future<dynamic> setPassword(String password, String confirmPassword) async {
    Map<String, dynamic> params = {
      "new_password": password,
      "new_password2": confirmPassword
    };

    await apiClient.postHTTP(
      "/set-password/",
      params,
    );
  }
}
