import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:redstonex/net/exception/net_exception.dart';

bool handleException(ApiException exception, {bool Function(ApiException)? onError}) {
  if (onError?.call(exception) == true) {
    return true;
  }

  if (exception.code == 401) {
    return true;
  }
  EasyLoading.showError(exception.message ?? ApiException.unknownException);

  return false;
}
