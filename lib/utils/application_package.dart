import 'package:package_info_plus/package_info_plus.dart';

class XAppPackage {
  static final XAppPackage _single = XAppPackage._internal();

  XAppPackage._internal();

  factory XAppPackage() => _single;

  /// 应用包信息
  static late PackageInfo _package;

  Future<void> initial() async {
    _package = await PackageInfo.fromPlatform();
  }

  String appName() => _package.appName;

  String packageName() => _package.packageName;

  String version() => _package.version;

  String buildNumber() => _package.buildNumber;

  String buildSignature() => _package.buildSignature;
}
