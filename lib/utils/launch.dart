import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'toast.dart';

class XLaunch {
  static final XLaunch _single = XLaunch._internal();

  XLaunch._internal();

  factory XLaunch() => _single;

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
      XToast().show('ERR TEL URL');
    }
  }
}
