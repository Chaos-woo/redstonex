import 'package:flutter/services.dart';

class rVersion {
  static final rVersion _single = rVersion._internal();

  rVersion._internal();

  factory rVersion() => _single;

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
