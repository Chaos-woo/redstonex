import 'package:package_info_plus/package_info_plus.dart';

/// A package information function set.
///
class PackageFunc {
  /// base package information
  static late PackageInfo _info;

  /// Initial package information
  ///
  /// Need call [initial] method before using package information
  static Future<void> init() async {
    _info = await PackageInfo.fromPlatform();
  }

  /// App name
  static String appName() => _info.appName;

  /// Package name
  static String packageName() => _info.packageName;

  /// Version
  static String version() => _info.version;

  /// Build number
  static String buildNumber() => _info.buildNumber;

  /// Build signature
  static String buildSignature() => _info.buildSignature;
}
