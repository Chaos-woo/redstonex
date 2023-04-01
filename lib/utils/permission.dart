import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class XPermission {
  static final XPermission _single = XPermission._internal();

  XPermission._internal();

  factory XPermission() => _single;

  Future<void> checkPermission(
    Permission permission, {
    VoidCallback? onGranted,
    bool deniedAutoRequest = true,
    VoidCallback? onDenied,
    VoidCallback? onRestricted,
    VoidCallback? onPermanentlyDenied,
  }) async {
    var status = await permission.status;
    if (status.isDenied) {
      // 如果权限被拒绝，可以尝试再次请求权限
      onDenied?.call();
      if (deniedAutoRequest) {
        requestPermission(
          permission,
          onGranted: onGranted,
        );
      }
    } else if (status.isGranted) {
      // 已经授予了权限
      onGranted?.call();
    } else if (status.isRestricted) {
      // 如果权限受到限制，例如家长控制，则需要用户进行额外的操作
      onRestricted?.call();
    } else if (status.isPermanentlyDenied) {
      // 如果权限被永久拒绝，则需要用户手动启用权限
      onPermanentlyDenied?.call();
      openAppSettings();
    }
  }

  Future<void> requestPermission(
    Permission permission, {
    VoidCallback? onGranted,
    VoidCallback? onDenied,
    VoidCallback? onPermanentlyDenied,
  }) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // 用户授予了权限
      onGranted?.call();
    } else if (status.isDenied) {
      // 用户拒绝了权限
      onDenied?.call();
    } else if (status.isPermanentlyDenied) {
      // 用户永久拒绝了权限，需要手动启用权限
      onPermanentlyDenied?.call();
      openAppSettings();
    }
  }
}
