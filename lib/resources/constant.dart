import 'package:flutter/foundation.dart';

class rConstant {

  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = kReleaseMode;

  static bool isDriverTest  = false;
  static bool isUnitTest  = false;

  static const String phone = 'phone';

  static const String theme = 'AppTheme';
  static const String locale = 'locale';

}
