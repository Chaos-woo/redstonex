import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/utils/theme_utils.dart';

class DialogUtils {
  static Future<void> showPromptDialog<T>({
    required String title,
    TextStyle? titleStyle,
    required String content,
    TextStyle? contentStyle,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? backgroundColor,
    Color? buttonColor = Colors.transparent,
    WillPopCallback? onWillPop,
    bool barrierDismissible = true,
    double dialogRadius = 20.0,
    List<Widget>? actions,
    Function(T? result)? callback,
  }) async {
    T? result = await Get.defaultDialog<T>(
      title: title,
      titlePadding: const EdgeInsets.all(3),
      titleStyle: titleStyle,
      middleText: content,
      middleTextStyle: contentStyle,
      contentPadding: const EdgeInsets.all(5),
      textConfirm: textConfirm,
      confirmTextColor: confirmTextColor,
      onConfirm: onConfirm,
      textCancel: textCancel,
      cancelTextColor: cancelTextColor,
      onCancel: onCancel,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      radius: dialogRadius,
      actions: actions,
    );
    callback?.call(result);
  }

  static Widget dialogButton({
    required String text,
    Color? buttonColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: buttonColor ?? ThemeUtils.theme().colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor ?? ThemeUtils.theme().backgroundColor),
      ),
      onPressed: () => onTap?.call(),
    );
  }

  static Future<void> showElasticDialog<T>({
    required String title,
    TextStyle? titleStyle,
    required WidgetBuilder contentBuilder,
    EdgeInsetsGeometry? contentPadding,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? backgroundColor,
    Color? buttonColor = Colors.transparent,
    WillPopCallback? onWillPop,
    bool barrierDismissible = true,
    double dialogRadius = 20.0,
    List<Widget>? actions,
    Function(T? result)? callback,
  }) async {
    T? result = await Get.defaultDialog<T>(
      title: title,
      titlePadding: const EdgeInsets.all(3),
      titleStyle: titleStyle,
      content: contentBuilder.call(Get.context!),
      contentPadding: contentPadding ?? const EdgeInsets.all(5),
      textConfirm: textConfirm,
      confirmTextColor: confirmTextColor,
      onConfirm: onConfirm,
      textCancel: textCancel,
      cancelTextColor: cancelTextColor,
      onCancel: onCancel,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      radius: dialogRadius,
      actions: actions,
    );
    callback?.call(result);
  }
}
