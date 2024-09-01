import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/app_storage.dart';
import 'api_helper.dart';
import 'app_interceptor.dart';
import 'json_api_encoder_interceptor.dart';

class ApiClient {
  late Rx<AppStorage> store;
  late Dio _dioClient;
  Map<String, String>? proxy;

  ApiClient({
    required dioClient,
    required this.store,
  }) {
    _dioClient = dioClient;
  }

  ApiClient.fromStore({
    required this.store,
    //Map<String, String>? proxy,
    required String baseUrl,
  }) {
    _dioClient = Dio(baseOptions(
      baseUrl,
    ));
    //_dioClient.interceptors.add(ForceUpgradeInterceptor());
    var interceptorClient = Dio(
      baseOptions(baseUrl),
    );
    _dioClient.interceptors
        .add(AppInterceptor(store: store, dio: interceptorClient));

    _dioClient.interceptors.add(JsonApiEncoderInterceptor());

    if (!kReleaseMode) {
      _dioClient.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        compact: false,
      ));
    }

    // if (proxy != null) {
    //   final proxyString = '${proxy['host']}:${proxy['port']}';
    //   (_dioClient.httpClientAdapter as DefaultHttpClientAdapter)
    //       .onHttpClientCreate = (client) {
    //     // Hook into the findProxy callback to set the client's proxy.
    //     client.findProxy = (url) {
    //       return 'PROXY $proxyString';
    //     };
    //
    //     // This is a workaround to allow Proxyman to receive
    //     // SSL payloads when your app is running on Android.
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => Platform.isAndroid;
    //     return null;
    //   };
    // }
  }

  Future<Response?> deleteHTTP(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    return mapException(
      () => _dioClient.delete(url,
          data: data, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response> getHTTP(String url,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    return mapException(
      () => _dioClient.get(url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken),
    );
  }

  Future<Response> patchHTTP(String url, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return mapException(
      () => _dioClient.patch(url,
          data: data, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response> postHTTP(String url, dynamic data,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    return mapException(
      () => _dioClient.post(url,
          data: data, queryParameters: queryParameters, options: options),
    );
  }

  Future<Response?> putHTTP(String url, dynamic data) async {
    return mapException(
      () => _dioClient.put(url, data: data),
    );
  }

  static BaseOptions baseOptions(String url) {
    return BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),

        /// When use cancel token, Dio send user agent as a null and the app always get 403 status
        /// We need this user agent header to fix the issue;
        /// ref: https://github.com/flutterchina/dio/issues/1487
        headers: {HttpHeaders.userAgentHeader: 'dio'});
  }
}
