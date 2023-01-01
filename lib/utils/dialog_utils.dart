import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/utils/theme_utils.dart';

class DialogUtils {
  static Future<void> showPromptDialog<T>({
    String? title,
    TextStyle? titleStyle,
    Widget? contentWidget,
    String? content,
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
    List<Widget>? actions,
    Function(T? result)? callback,
  }) async {
    T? result = await _innerDialog(
      title: title,
      titleTextStyle: titleStyle,
      contentWidget: contentWidget,
      content: content,
      contentTextStyle: contentStyle,
      onConfirm: onConfirm,
      onCancel: onCancel,
      cancelTextColor: cancelTextColor,
      confirmTextColor: confirmTextColor,
      textConfirm: textConfirm,
      textCancel: textCancel,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      bottomActions: actions,
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
        style: TextStyle(color: textColor ?? ThemeUtils.theme().primaryColor),
      ),
      onPressed: () => onTap?.call(),
    );
  }

  static Widget textButton({
    required String text,
    Color? buttonColor,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(color: textColor ?? ThemeUtils.theme().primaryColor),
      ),
      onPressed: () => onTap?.call(),
    );
  }

  static Future<void> showElasticDialog<T>({
    Widget? title,
    Widget? content,
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
    List<Widget>? actions,
    Function(T? result)? callback,
  }) async {
    T? result = await _innerDialog(
      titleWidget: title,
      contentWidget: content,
      onConfirm: onConfirm,
      onCancel: onCancel,
      cancelTextColor: cancelTextColor,
      confirmTextColor: confirmTextColor,
      textConfirm: textConfirm,
      textCancel: textCancel,
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      bottomActions: actions,
    );
    callback?.call(result);
  }

  static Future<T?> _innerDialog<T>({
    String? title,
    String? content,
    TextStyle? titleTextStyle,
    TextStyle? contentTextStyle,
    Widget? titleWidget,
    Widget? contentWidget,
    Color? backgroundColor = Colors.white,
    bool barrierDismissible = true,
    WillPopCallback? onWillPop,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? buttonColor = Colors.transparent,
    List<Widget>? bottomActions,
  }) {
    if (title == null && content == null && titleWidget == null && contentWidget == null) {
      return Future.value(null);
    }

    List<Widget> actions = _buildBottomActions(
      textCancel: textCancel,
      textConfirm: textConfirm,
      onConfirm: onConfirm,
      onCancel: onCancel,
      buttonColor: buttonColor,
      confirmTextColor: confirmTextColor,
      cancelTextColor: cancelTextColor,
      bottomActions: bottomActions,
    );
    Widget alertDialog = AlertDialog(
      title: titleWidget ?? Text(title ?? '', style: titleTextStyle),
      content: contentWidget ?? Text(content ?? '', style: contentTextStyle),
      backgroundColor: backgroundColor,
      actions: actions,
    );

    return Get.dialog<T>(
      onWillPop != null
          ? WillPopScope(
              onWillPop: onWillPop,
              child: alertDialog,
            )
          : alertDialog,
      barrierDismissible: barrierDismissible,
    );
  }

  static List<Widget> _buildBottomActions({
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    Color? buttonColor,
    List<Widget>? bottomActions,
  }) {
    if (bottomActions != null) {
      return bottomActions;
    }

    List<Widget> actions = [];
    if (textCancel != null) {
      actions.add(dialogButton(
        text: textCancel,
        textColor: cancelTextColor,
        onTap: onCancel,
        buttonColor: buttonColor,
      ));
    }
    if (textConfirm != null) {
      actions.add(dialogButton(
        text: textConfirm,
        textColor: confirmTextColor,
        onTap: onConfirm,
        buttonColor: buttonColor,
      ));
    }
    return actions;
  }
}
