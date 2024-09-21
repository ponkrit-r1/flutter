import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

import '../data/app_storage.dart';
import '../domain/user_session.dart';

class AppInterceptor extends Interceptor {
  final Rx<AppStorage> store;
  final Dio dio;
  static const languageHeader = 'tto-Language';

  AppInterceptor({
    required this.store,
    required this.dio,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final userSession = await store.value.getUserSession();
    //final language = store.value.getUserLanguage() ?? SupportedLocale.th;

    //options.headers[languageHeader] = language.value;

    if (userSession != null) {
      options.headers['Authorization'] = 'Bearer ${userSession.accessToken}';
    } else {
      // Not logged in
      options.headers.remove('Authorization');
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // There are many
    if (err.response?.statusCode == 401) {
      debugPrint('Need refresh');

      final userSession = await store.value.getUserSession();
      final refreshToken = userSession?.refreshToken;
      if (refreshToken == null) {
        super.onError(err, handler);
        return;
      }

      try {
        debugPrint("refreshed");
        final newSession = await _refresh(refreshToken);
        handleRetryRequest(err, handler);
      } catch (error) {
        // Failed refresh token
        // For easy handler we pass back 401 which mean log out.
        await store.value.logout();
        super.onError(err, handler);
      }
    } else {
      super.onError(err, handler);
    }
  }

  Future<void> handleRetryRequest(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final newResponse = await _retry(err.requestOptions);
      handler.resolve(newResponse);
    } catch (error) {
      super.onError(err, handler);
    }
  }

  // Refresh token.
  Future<UserSession?> _refresh(String refreshToken) async {
    final params = {
      "refresh": refreshToken,
    };

    debugPrint("_refreshing");

    final response = await dio.post(
      '/login/refresh/',
      queryParameters: params,
    );
    final userSession = UserSession.fromJson(response.data);

    await store.value.setUserSession(userSession);
    store.refresh();

    return userSession;
  }

  // Retry failed request
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
