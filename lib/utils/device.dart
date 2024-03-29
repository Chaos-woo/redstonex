import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

import '../resources/constant.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
class rDevice {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static bool get isMobile => isAndroid || isIOS;

  static bool get isWeb => kIsWeb;

  static bool get isWindows => !isWeb && Platform.isWindows;

  static bool get isLinux => !isWeb && Platform.isLinux;

  static bool get isMacOS => !isWeb && Platform.isMacOS;

  static bool get isAndroid => !isWeb && Platform.isAndroid;

  static bool get isFuchsia => !isWeb && Platform.isFuchsia;

  static bool get isIOS => !isWeb && Platform.isIOS;

  static late AndroidDeviceInfo androidInfo;

  static late IosDeviceInfo iosDeviceInfo;

  static Future<void> initial() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid) {
      androidInfo = await deviceInfo.androidInfo;
    }

    if (isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    }
  }

  /// 使用前记得初始化
  static int getAndroidSdkInt() {
    if (rConstant.isDriverTest) {
      return -1;
    }
    if (isAndroid) {
      return androidInfo.version.sdkInt ?? -1;
    } else {
      return -1;
    }
  }
}
