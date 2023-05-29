import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../app-configs/global_config.dart';
import 'api_exception.dart';

bool handleException(rApiException exception, {bool Function(rApiException)? onError}) {
  if (onError?.call(exception) == true) {
    return true;
  }

  if (exception.code == 401) {
    return true;
  }

  EasyLoading.showError(
    exception.message ?? rGlobalConfig.instance.globalHttpOptionConfigs.httpError.eDefault,
  );

  return false;
}
