import 'dart:io';

import 'package:dio/dio.dart';
import 'package:redstonex/functions/basic-functions/network_helper.dart';
import 'package:redstonex/network-core/definitions/network_exception.dart';

/// Error handle interceptor
class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.other) {
      final defExText = NetworkException.defExceptionText();
      bool isConnectNetWork = await NetworkHelper.networkConnectivity();
      if (!isConnectNetWork && err.error is SocketException) {
        err.error = SocketException(defExText.errNoNet);
      } else if (err.error is SocketException) {
        err.error = SocketException(defExText.errNetwork);
      }
    }

    /// business error handled by next processor
    /// eg. http not 200 status or personal business
    /// error code.
    err.error = NetworkException.dio(err);
    super.onError(err, handler);
  }
}
