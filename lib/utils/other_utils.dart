import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:redstonex/utils/theme_utils.dart';
import 'package:redstonex/utils/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  /// 打开链接
  static Future<void> launchWebURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ToastUtils.show('ERR URL');
    }
  }

  /// 调起拨号页
  static Future<void> launchTelURL(String phone) async {
    final Uri uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ToastUtils.show('ERR TEL URL');
    }
  }

  static String formatPrice(String price, {MoneyFormat format = MoneyFormat.END_INTEGER}) {
    return MoneyUtil.changeYWithUnit(NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN, format: format);
  }

  static KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list,
      {String? closeText}) {
    return KeyboardActionsConfig(
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      actions: List.generate(
          list.length,
          (i) => KeyboardActionsItem(
                focusNode: list[i],
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () => node.unfocus(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: closeText != null ? Text(closeText) : const Icon(Icons.close),
                      ),
                    );
                  },
                ],
              )),
    );
  }
}
