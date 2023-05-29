import 'package:dio/dio.dart';

import '../../app-configs/global_config.dart';
import '../../app-configs/user-configs/global_app_configs.dart';
import '../../app-configs/user-configs/global_http_option_configs.dart';
import '../response/api_response.dart';

class rApiException implements Exception {
  final String? message;
  final int? code;
  String? details;

  rApiException([this.code, this.message]);

  factory rApiException.fromDioError(DioError error) {
    rGlobalAppConfigs globalAppConfigs = rGlobalConfig.instance.globalAppConfigs;
    GlobalDioError gDioError = rGlobalConfig.instance.globalHttpOptionConfigs.dioError;

    switch (error.type) {
      case DioErrorType.cancel:
        return rBadRequestException(globalAppConfigs.appErrorCode, gDioError.cancel);
      case DioErrorType.connectTimeout:
        return rBadRequestException(globalAppConfigs.appErrorCode, gDioError.connectTimeout);
      case DioErrorType.sendTimeout:
        return rBadRequestException(globalAppConfigs.appErrorCode, gDioError.sendTimeout);
      case DioErrorType.receiveTimeout:
        return rBadRequestException(globalAppConfigs.appErrorCode, gDioError.receiveTimeout);
      case DioErrorType.response:
        GlobalHttpError gHttpError = rGlobalConfig.instance.globalHttpOptionConfigs.httpError;
        try {
          /// http错误码带业务错误信息
          rApiResponse apiResponse = rApiResponse.fromJson(error.response?.data);
          if (apiResponse.code != null) {
            return rApiException(apiResponse.code, apiResponse.message);
          }

          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return rBadRequestException(errCode, gHttpError.e400);
            case 401:
              return rUnauthorisedException(errCode!, gHttpError.e401);
            case 403:
              return rUnauthorisedException(errCode!, gHttpError.e403);
            case 404:
              return rUnauthorisedException(errCode!, gHttpError.e404);
            case 405:
              return rUnauthorisedException(errCode!, gHttpError.e405);
            case 500:
              return rUnauthorisedException(errCode!, gHttpError.e500);
            case 502:
              return rUnauthorisedException(errCode!, gHttpError.e502);
            case 503:
              return rUnauthorisedException(errCode!, gHttpError.e503);
            case 505:
              return rUnauthorisedException(errCode!, gHttpError.e505);
            default:
              return rApiException(errCode, error.response?.statusMessage ?? gHttpError.eDefault);
          }
        } on Exception {
          return rApiException(globalAppConfigs.appErrorCode, gHttpError.eDefault);
        }
      default:
        return rApiException(globalAppConfigs.appErrorCode, error.message);
    }
  }

  factory rApiException.from(dynamic exception) {
    if (exception is DioError) {
      return rApiException.fromDioError(exception);
    }
    if (exception is rApiException) {
      return exception;
    } else {
      var apiException = rApiException(rGlobalConfig.instance.globalAppConfigs.appErrorCode,
          rGlobalConfig.instance.globalHttpOptionConfigs.httpError.eDefault);
      apiException.details = exception?.toString();
      return apiException;
    }
  }
}

/// 请求错误
class rBadRequestException extends rApiException {
  rBadRequestException([int? code, String? message]) : super(code, message);
}

/// 未认证异常
class rUnauthorisedException extends rApiException {
  rUnauthorisedException([int code = -1, String message = '']) : super(code, message);
}
