import 'package:dio/dio.dart';

import '../../app-configs/global_config.dart';
import '../../app-configs/user-configs/global_app_configs.dart';
import '../../app-configs/user-configs/global_http_option_configs.dart';
import '../response/api_response.dart';

class ApiException implements Exception {
  final String? message;
  final int? code;
  String? details;

  ApiException([this.code, this.message]);

  factory ApiException.fromDioError(DioError error) {
    GlobalAppConfigs globalAppConfigs = GlobalConfig.instance.globalAppConfigs;
    GlobalDioError gDioError = GlobalConfig.instance.globalHttpOptionConfigs.dioError;

    switch (error.type) {
      case DioErrorType.cancel:
        return BadRequestException(globalAppConfigs.appErrorCode, gDioError.cancel);
      case DioErrorType.connectTimeout:
        return BadRequestException(globalAppConfigs.appErrorCode, gDioError.connectTimeout);
      case DioErrorType.sendTimeout:
        return BadRequestException(globalAppConfigs.appErrorCode, gDioError.sendTimeout);
      case DioErrorType.receiveTimeout:
        return BadRequestException(globalAppConfigs.appErrorCode, gDioError.receiveTimeout);
      case DioErrorType.response:
        GlobalHttpError gHttpError = GlobalConfig.instance.globalHttpOptionConfigs.httpError;
        try {
          /// http错误码带业务错误信息
          ApiResponse apiResponse = ApiResponse.fromJson(error.response?.data);
          if (apiResponse.code != null) {
            return ApiException(apiResponse.code, apiResponse.message);
          }

          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(errCode, gHttpError.e400);
            case 401:
              return UnauthorisedException(errCode!, gHttpError.e401);
            case 403:
              return UnauthorisedException(errCode!, gHttpError.e403);
            case 404:
              return UnauthorisedException(errCode!, gHttpError.e404);
            case 405:
              return UnauthorisedException(errCode!, gHttpError.e405);
            case 500:
              return UnauthorisedException(errCode!, gHttpError.e500);
            case 502:
              return UnauthorisedException(errCode!, gHttpError.e502);
            case 503:
              return UnauthorisedException(errCode!, gHttpError.e503);
            case 505:
              return UnauthorisedException(errCode!, gHttpError.e505);
            default:
              return ApiException(errCode, error.response?.statusMessage ?? gHttpError.eDefault);
          }
        } on Exception {
          return ApiException(globalAppConfigs.appErrorCode, gHttpError.eDefault);
        }
      default:
        return ApiException(globalAppConfigs.appErrorCode, error.message);
    }
  }

  factory ApiException.from(dynamic exception) {
    if (exception is DioError) {
      return ApiException.fromDioError(exception);
    }
    if (exception is ApiException) {
      return exception;
    } else {
      var apiException = ApiException(GlobalConfig.instance.globalAppConfigs.appErrorCode,
          GlobalConfig.instance.globalHttpOptionConfigs.httpError.eDefault);
      apiException.details = exception?.toString();
      return apiException;
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([int? code, String? message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int code = -1, String message = '']) : super(code, message);
}
