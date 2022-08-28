import 'package:dio/dio.dart';
import 'package:redstonex/commons/exceptions/bad_request_exception.dart';
import 'package:redstonex/commons/exceptions/exts/i10n_exception_text.dart';
import 'package:redstonex/commons/exceptions/network_exception.dart';
import 'package:redstonex/commons/exceptions/not_found_exception.dart';
import 'package:redstonex/commons/exceptions/server_exception.dart';
import 'package:redstonex/commons/exceptions/unauthorised_exception.dart';
import 'package:redstonex/commons/utils/reference_utils.dart';

/// App abstract/base exception.
///
/// Any exception should be subclass of [AppException].
///
/// For multi language basic error message, should implements
/// [I10nExceptionText] and put in GetX bean container and tag
/// only is [fixedI10nBaseErrTag].
class AppException implements Exception {
  static const String fixedI10nBaseErrTag = 'fixedI10nBaseErr';
  static const int fixedErrCode = -1;

  final int errCode;
  final String message;

  AppException(this.errCode, this.message);

  factory AppException.http(DioError error) {
    I10nExceptionText i10nErr = _i10nBaseErr();

    switch (error.type) {
      case DioErrorType.cancel:
        {
          return NetworkException(fixedErrCode, i10nErr.cancelRequest);
        }
      case DioErrorType.connectTimeout:
        {
          return NetworkException(fixedErrCode, i10nErr.connectTimeout);
        }
      case DioErrorType.sendTimeout:
        {
          return NetworkException(fixedErrCode, i10nErr.writeTimeout);
        }
      case DioErrorType.receiveTimeout:
        {
          return NetworkException(fixedErrCode, i10nErr.readTimeout);
        }
      case DioErrorType.response:
        {
          try {
            int? errCode = error.response!.statusCode;
            switch (errCode) {
              case 400:
                {
                  return BadRequestException(errCode!, i10nErr.err400);
                }
              case 401:
                {
                  return UnauthorisedException(errCode!, i10nErr.err401);
                }
              case 403:
                {
                  return UnauthorisedException(errCode!, i10nErr.err403);
                }
              case 404:
                {
                  return NotFoundException(errCode!, i10nErr.err404);
                }
              case 405:
                {
                  return BadRequestException(errCode!, i10nErr.err405);
                }
              case 500:
                {
                  return ServerException(errCode!, i10nErr.err500);
                }
              case 502:
                {
                  return ServerException(errCode!, i10nErr.err502);
                }
              case 503:
                {
                  return ServerException(errCode!, i10nErr.err503);
                }
              case 505:
                {
                  return ServerException(errCode!, i10nErr.err505);
                }
              default:
                {
                  return AppException(errCode!, error.response!.statusMessage!);
                }
            }
          } on Exception catch (_) {
            return AppException(fixedErrCode, i10nErr.errDef);
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
  /// Extending [I10nExceptionText] and override method, putting in
  /// GetX bean container and fixed tag tagged [AppException.fixedI10nBaseErrTag].
  /// Finally, app exception will using multi language error message.
  static I10nExceptionText _i10nBaseErr() {
    if (ReferenceUtils.exist<I10nExceptionText>(tag: fixedI10nBaseErrTag)) {
      return ReferenceUtils.find<I10nExceptionText>(tag: fixedI10nBaseErrTag);
    } else {
      I10nExceptionText def = I10nExceptionText();
      return ReferenceUtils.put(def, tag: fixedI10nBaseErrTag);
    }
  }
}
