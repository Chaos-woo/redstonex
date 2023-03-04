import 'package:flutter/services.dart';

class XVersion {
  static final XVersion _single = XVersion._internal();

  XVersion._internal();

  factory XVersion() => _single;

  static const MethodChannel _kChannel = MethodChannel('version');

  /// 应用安装
  void install(String path) {
    _kChannel.invokeMethod<void>('install', {'path': path});
  }

  /// AppStore跳转
  void jumpAppStore() {
    _kChannel.invokeMethod<void>('jumpAppStore');
  }
}
