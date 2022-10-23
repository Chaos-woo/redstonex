import 'package:dio/dio.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/reflections_utils.dart';
import 'package:redstonex/network-core/definitions/def_exception_text.dart';

class NetworkException implements Exception {
  final int _code;
  final String _msg;

  NetworkException(this._code, this._msg);

  int get code => _code;

  String get msg => _msg;

  @override
  String toString() {
    return 'NetworkException{$_code : $_msg}';
  }

  factory NetworkException.dio(DioError error) {
    const int fixedErrCode = DefExceptionText.fixedErrCode;
    final defExText = defExceptionText();

    switch (error.type) {
      case DioErrorType.cancel:
        {
          return NetworkException(fixedErrCode, defExText.cancelRequest);
        }
      case DioErrorType.connectTimeout:
        {
          return NetworkException(fixedErrCode, defExText.connectTimeout);
        }
      case DioErrorType.sendTimeout:
        {
          return NetworkException(fixedErrCode, defExText.writeTimeout);
        }
      case DioErrorType.receiveTimeout:
        {
          return NetworkException(fixedErrCode, defExText.readTimeout);
        }
      case DioErrorType.response:
        {
          try {
            return NetworkException(
                error.response!.statusCode!, "HTTP ${error.response!.statusCode!}:${defExText.errServer}");
          } on Exception catch (_) {
            return NetworkException(fixedErrCode, error.error.message);
          }
        }
      default:
        {
          return NetworkException(fixedErrCode, error.error.message);
        }
    }
  }

  /// Get base exception.
  ///
  /// Extending [DefExceptionText] and override method, putting in
  /// GetX bean container and fixed tag tagged [DefExceptionText.fixedDefExceptionTextTag].
  /// Finally, app exception will using multi language error message.
  static DefExceptionText defExceptionText() {
    const tag = DefExceptionText.fixedDefExceptionTextTag;
    if (ReflectionsUtils.existInGetX<DefExceptionText>(tag: tag)) {
      return ReflectionsUtils.find<DefExceptionText>(tag: tag);
    } else {
      DefExceptionText def = DefExceptionText();
      return ReflectionsUtils.put(def, tag: tag);
    }
  }
}
