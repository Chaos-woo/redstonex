import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../app-configs/global_config.dart';
import 'api_exception.dart';

bool handleException(ApiException exception, {bool Function(ApiException)? onError}) {
  if (onError?.call(exception) == true) {
    return true;
  }

  if (exception.code == 401) {
    return true;
  }

  EasyLoading.showError(
      exception.message ?? GlobalConfig.instance.globalHttpOptionConfigs.httpError.eDefault);

  return false;
}
