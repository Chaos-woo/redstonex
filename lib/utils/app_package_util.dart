import 'package:package_info_plus/package_info_plus.dart';

class AppPackageUtils {
  /// base package information
  static late PackageInfo _pak;

  /// Initial package information
  ///
  /// Need call [init] method before using package information
  static Future<void> init() async {
    _pak = await PackageInfo.fromPlatform();
  }

  /// App name
  static String appName() => _pak.appName;

  /// Package name
  static String packageName() => _pak.packageName;

  /// Version
  static String version() => _pak.version;

  /// Build number
  static String buildNumber() => _pak.buildNumber;

  /// Build signature
  static String buildSignature() => _pak.buildSignature;
}
