import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'toast.dart';

class rLaunch {
  static final rLaunch _single = rLaunch._internal();

  rLaunch._internal();

  factory rLaunch() => _single;

  /// 打开链接
  Future<void> launch(
    String url, {
    VoidCallback? launchPreCallback,
    VoidCallback? exceptCallback,
  }) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchPreCallback?.call();
      await launchUrl(uri);
    } else {
      exceptCallback?.call();
    }
  }

  /// 调起拨号页
  Future<void> launchTel(String phone) async {
    final Uri uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      rToast().show('ERR TEL URL');
    }
  }
}
