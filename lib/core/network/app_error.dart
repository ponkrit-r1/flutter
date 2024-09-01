import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'error_response.dart';

enum AppErrorType {
  errorResponse,
  networkError,
  cancel,
  unknown,
  server,
}

class AppError implements Exception {
  AppError({
    required this.type,
    this.response,
  });

  /// Response info, it may be `null` if the error type is not `errorResponse`.
  ErrorResponse? response;
  AppErrorType type;

  @override
  String toString() {
    switch (type) {
      case AppErrorType.server:
        return 'เกิดความผิดพลาดของเซิฟเวอร์';
      case AppErrorType.errorResponse:
        return response?.description ?? '';
      case AppErrorType.cancel:
        return 'Cancelled';
      case AppErrorType.networkError:
        return AppLocalizations.of(Get.context!)!.networkErrorMessage;
      case AppErrorType.unknown:
        return AppLocalizations.of(Get.context!)!.unknownErrorMessage;
    }
  }
}
