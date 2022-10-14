import 'package:dio/dio.dart';
import 'package:redstonex/commons/exceptions/bad_request_exception.dart';
import 'package:redstonex/commons/exceptions/exts/i10n_exception_text.dart';
import 'package:redstonex/commons/exceptions/network_exception.dart';
import 'package:redstonex/commons/exceptions/not_found_exception.dart';
import 'package:redstonex/commons/exceptions/server_exception.dart';
import 'package:redstonex/commons/exceptions/unauthorised_exception.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/reflections_utils.dart';

/// App abstract/base exception.
///
/// Any exception should be subclass of [AppException].
///
/// For multi language basic error message, should implements
/// [I10nBaseExceptionText] and put in GetX bean container and tag
/// only is [fixedI10nExceptionTextTag].
class AppException implements Exception {
  static const String fixedI10nExceptionTextTag = 'fixedI10nExceptionText';
  static const int fixedErrCode = -1;

  final int errCode;
  final String message;

  AppException(this.errCode, this.message);

  factory AppException.http(DioError error) {
    I10nBaseExceptionText i10nException = _i10nExceptionText();

    switch (error.type) {
      case DioErrorType.cancel:
        {
          return NetworkException(fixedErrCode, i10nException.cancelRequest);
        }
      case DioErrorType.connectTimeout:
        {
          return NetworkException(fixedErrCode, i10nException.connectTimeout);
        }
      case DioErrorType.sendTimeout:
        {
          return NetworkException(fixedErrCode, i10nException.writeTimeout);
        }
      case DioErrorType.receiveTimeout:
        {
          return NetworkException(fixedErrCode, i10nException.readTimeout);
        }
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response!.statusCode;
            switch (errCode) {
              case 400:
                {
                  return BadRequestException(errCode!, i10nException.err400);
                }
              case 401:
                {
                  return UnauthorisedException(errCode!, i10nException.err401);
                }
              case 403:
                {
                  return UnauthorisedException(errCode!, i10nException.err403);
                }
              case 404:
                {
                  return NotFoundException(errCode!, i10nException.err404);
                }
              case 405:
                {
                  return BadRequestException(errCode!, i10nException.err405);
                }
              case 500:
                {
                  return ServerException(errCode!, i10nException.err500);
                }
              case 502:
                {
                  return ServerException(errCode!, i10nException.err502);
                }
              case 503:
                {
                  return ServerException(errCode!, i10nException.err503);
                }
              case 505:
                {
                  return ServerException(errCode!, i10nException.err505);
                }
              default:
                {
                  return AppException(errCode!, error.response!.statusMessage!);
                }
            }
          } on Exception catch (_) {
            return AppException(fixedErrCode, i10nException.errDef);
          }
        }
      default:
        {
          return AppException(fixedErrCode, error.error.message);
        }
    }
  }

  /// Get base exception.
  ///
  /// Extending [I10nBaseExceptionText] and override method, putting in
  /// GetX bean container and fixed tag tagged [AppException.fixedI10nExceptionTextTag].
  /// Finally, app exception will using multi language error message.
  static I10nBaseExceptionText _i10nExceptionText() {
    if (ReflectionsUtils.existInGetX<I10nBaseExceptionText>(tag: fixedI10nExceptionTextTag)) {
      return ReflectionsUtils.find<I10nBaseExceptionText>(tag: fixedI10nExceptionTextTag);
    } else {
      I10nBaseExceptionText def = I10nBaseExceptionText();
      return ReflectionsUtils.put(def, tag: fixedI10nExceptionTextTag);
    }
  }
}
