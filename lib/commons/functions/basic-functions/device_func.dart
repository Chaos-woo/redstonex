import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

/// A device information function set.
///
class DeviceFunc {
  /// base device information
  static final DeviceInfoPlugin _info = DeviceInfoPlugin();

  /// android information
  static late AndroidDeviceInfo _android;

  /// ios information
  static late IosDeviceInfo _ios;

  /// Get android information if current is android
  static AndroidDeviceInfo get androidDevInfo => _android;

  /// Get iOS information if current is iOS
  static IosDeviceInfo get iosDevInfo => _ios;

  /// Initial device information for platform
  ///
  /// Need call [initial] method before using device information
  static Future<void> init() async {
    if (isAndroid()) {
      _android = await _info.androidInfo;
    }

    if (isIOS()) {
      _ios = await _info.iosInfo;
    }
  }

  /// Platform whether android
  static bool isAndroid() => Platform.isAndroid;

  /// Platform whether ios
  static bool isIOS() => Platform.isIOS;

  /// Platform whether linux
  static bool isLinux() => Platform.isLinux;

  /// Platform whether windows
  static bool isWindow() => Platform.isWindows;

  /// Device brand, android system return brand, iOS system return model
  static String brand() {
    if (isAndroid()) {
      return _android.brand ?? '';
    } else if (isIOS()) {
      return _ios.model ?? '';
    }

    return '';
  }

  /// Get current operate system
  static String operateSystem() => Platform.operatingSystem;

  /// Get current operate system version
  static String operateSystemVersion() => Platform.operatingSystemVersion;
}
