import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redstonex/utils/colour_utils.dart';

/// [SystemChrome]工具
class SystemChromeUtils {
  /// 设置应用程序方向：竖直上
  static void setDeviceOrientationPortraitUp() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  /// 设置应用程序方向：竖直下
  static void setDeviceOrientationPortraitDown() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  }

  /// 设置应用程序方向：竖直左
  static void setDeviceOrientationLandscapeLeft() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  /// 设置应用程序方向：竖直右
  static void setDeviceOrientationLandscapeRight() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }

  /// 设置系统状态栏、底部按钮栏是否隐藏
  static Future<void> enableSystemUIOverlays({
    List<SystemUiOverlay> reservedOverlays = const [...SystemUiOverlay.values],
  }) async {
    /// 默认都保留
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: reservedOverlays);
  }

  /// 设置顶部状态栏颜色
  static void setTopSystemOverlayStyle(Color color, Brightness iconBrightness) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: color, statusBarIconBrightness: iconBrightness);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /// 设置底部状态栏颜色
  static void setBottomSystemOverlayStyle(Color color, Brightness iconBrightness) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(systemNavigationBarColor: color, systemNavigationBarIconBrightness: iconBrightness);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /// 设置应用程序在web中的展示描述
  static void setApplicationWebSwitcherDescription({String? label, Color? primaryColor}) async {
    await SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(label: label, primaryColor: primaryColor?.toHex()));
  }
}

class SystemUIOverlay {
  static List<SystemUiOverlay> all = const [...SystemUiOverlay.values];
  static List<SystemUiOverlay> onlyTop = const [SystemUiOverlay.top];
  static List<SystemUiOverlay> onlyBottom = const [SystemUiOverlay.bottom];
  static List<SystemUiOverlay> empty = const <SystemUiOverlay>[];
}
