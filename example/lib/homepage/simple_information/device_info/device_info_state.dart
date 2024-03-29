import 'package:redstonex/redstonex.dart';

class DeviceInfoState {
  String? board;
  String? brand;
  String? industrialDesignName;
  String? displayName;
  String? deviceModel;
  String? manufacturer;
  String? host;
  String? androidBaseOS;

  String? appName;
  String? appVersion;
  String? buildNumber;
  String? packageName;

  DeviceInfoState();

  void init() {
    var android = rDevice.androidInfo;
    board = android.board;
    brand = android.brand;
    industrialDesignName = android.device;
    displayName = android.display;
    deviceModel = android.model;
    manufacturer = android.manufacturer;
    host = android.host;
    androidBaseOS = android.version.baseOS;

    appName = rApplicationPackage().appName();
    appVersion = rApplicationPackage().version();
    buildNumber = rApplicationPackage().buildNumber();
    packageName = rApplicationPackage().packageName();
  }
}
