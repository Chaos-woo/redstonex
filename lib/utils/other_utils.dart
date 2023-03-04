import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:redstonex/utils/theme.dart';


class XUtil {
  static final XUtil _single = XUtil._internal();

  XUtil._internal();

  factory XUtil() => _single;

  String formatPrice(String price, {MoneyFormat format = MoneyFormat.END_INTEGER}) {
    return MoneyUtil.changeYWithUnit(NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN, format: format);
  }

  KeyboardActionsConfig getKeyboardActionsConfig(BuildContext context, List<FocusNode> list, {String? closeText}) {
    return KeyboardActionsConfig(
      keyboardBarColor: XTheme().getKeyboardActionsColor(),
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
