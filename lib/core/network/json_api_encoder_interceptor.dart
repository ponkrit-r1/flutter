import 'dart:convert';

import 'package:dio/dio.dart';

const jsonApiContentType = "application/vnd.api+json";

/// This class reference from https://github.com/cfug/dio/issues/1108
/// Now we remove onResponse and onError cause .toString function not work with json.decode
class JsonApiEncoderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isJsonApi(options.contentType)) {
      options.data = json.encode(options.data);
    }

    handler.next(options);
  }

  bool _isJsonApi(String? contentType) =>
      contentType?.startsWith(jsonApiContentType) ?? false;
}
