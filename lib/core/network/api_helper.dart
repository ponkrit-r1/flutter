import 'package:dio/dio.dart';

import 'app_error.dart';
import 'error_response.dart';

/// A callback that returns a Dio response, presumably from a Dio method
/// it has called which performs an HTTP request, such as `dio.get()`,
/// `dio.post()`, etc.
typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

Future<Response<T>> mapException<T>(HttpLibraryMethod<T> method) async {
  try {
    return await method();
  } on DioError catch (err) {
    switch (err.type) {
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 500:
            throw AppError(type: AppErrorType.server);
          default:
            final errorResponse = err.response;
            if (errorResponse != null) {
              try {
                throw AppError(
                    type: AppErrorType.errorResponse,
                    response: errorResponse.data);
              } catch (e) {
                if (e is AppError) {
                  rethrow;
                } else {
                  throw AppError(type: AppErrorType.unknown);
                }
              }
            } else {
              throw AppError(type: AppErrorType.unknown);
            }
        }
      case DioErrorType.cancel:
        throw AppError(type: AppErrorType.cancel);
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.unknown:
      case DioErrorType.badCertificate:
      case DioExceptionType.connectionError:
        throw AppError(type: AppErrorType.networkError);
    }
  } catch (e) {
    throw AppError(type: AppErrorType.unknown);
  }
}
