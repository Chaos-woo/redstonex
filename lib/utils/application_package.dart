import 'package:package_info_plus/package_info_plus.dart';

class XAppPackage {
  static final XAppPackage _single = XAppPackage._internal();

  XAppPackage._internal();

  factory XAppPackage() => _single;

  /// base package information
  static late PackageInfo _pak;

  /// Initial package information
  ///
  /// Need call [init] method before using package information
  Future<void> init() async {
    _pak = await PackageInfo.fromPlatform();
  }

  /// App name
  String appName() => _pak.appName;

  /// Package name
  String packageName() => _pak.packageName;

  /// Version
  String version() => _pak.version;

  /// Build number
  String buildNumber() => _pak.buildNumber;

  /// Build signature
  String buildSignature() => _pak.buildSignature;
}
