import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:salama_users/core/exception/errors.dart';
import 'package:salama_users/core/exception/failures.dart';


class ExceptionHandler {
  static Failure networkError(dynamic e) {
    Logger().d(e);
    if (e is NoInternetException) {
      return NoInternetFailure();
    }
    if (e is DioException) {
      Logger().d(e.response?.data);
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return TimeoutFailure();
      }
      if (e.response?.data != null) {
        if (e.response?.data?.runtimeType == String) {
          return ServerFailure(
            message: 'Server error, please try again!',
            code: e.response?.statusCode ?? 500,
          );
        } else {
          return ServerFailure(
            message: (e.response!.data as Map<String, dynamic>?)?['message']
                    as String? ??
                (e.response!.data as Map<String, dynamic>?)?['error']
                    as String? ??
                'Service unavailable, please try again!',
            code: e.response?.statusCode ?? 500,
          );
        }
      } else {
        return ServerFailure(
          message: 'Server error, please try again!',
          code: e.response?.statusCode ?? 500,
        );
      }
    } else {
    
      return UnknownFailure();
    }
  }
}
