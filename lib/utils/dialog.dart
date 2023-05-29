import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'theme.dart';

class rDialog {
  static final rDialog _single = rDialog._internal();

  rDialog._internal();

  factory rDialog() => _single;

  /// 操作为主的dialog
  void showActionDialog(
    List<Widget> buttons, {
    Widget? content,
    Widget Function()? divideBuilder,
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
    Color? buttonColor = Colors.transparent,
    WillPopCallback? onWillPop,
    bool barrierDismissible = true,
    Clip? dialogClipBehavior,
    ShapeBorder? shape,
  }) async {
    await _innerDialog(
      title: title,
      titleTextStyle: titleStyle,
      contentWidget: <Widget>[
        if (content != null) content,
        ...buttons,
      ].toColumn(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      ),
      backgroundColor: backgroundColor,
      buttonColor: buttonColor,
      onWillPop: onWillPop,
      barrierDismissible: barrierDismissible,
      dialogClipBehavior: dialogClipBehavior,
      shape: shape,
    );
  }

  /// 内容为主的dialog
  Future<void> showPromptDialog<T>({
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
    Clip? dialogClipBehavior,
    ShapeBorder? shape,
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
      shape: shape,
      dialogClipBehavior: dialogClipBehavior,
    );
    callback?.call(result);
  }

  /// 自定义的dialog
  Future<void> showElasticDialog<T>({
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
    Clip? dialogClipBehavior,
    ShapeBorder? shape,
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
      dialogClipBehavior: dialogClipBehavior,
      shape: shape,
    );
    callback?.call(result);
  }

  Future<T?> _innerDialog<T>({
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
    Clip? dialogClipBehavior,
    ShapeBorder? shape,
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
      title: titleWidget ??
          Text(title ?? '', style: titleTextStyle, overflow: TextOverflow.ellipsis, maxLines: 2),
      content: contentWidget ?? Text(content ?? '', style: contentTextStyle),
      backgroundColor: backgroundColor,
      actions: actions,
      clipBehavior: dialogClipBehavior ?? Clip.none,
      shape: shape,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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

  List<Widget> _buildBottomActions({
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
      actions.add(TextButton(
        onPressed: onCancel,
        child: Text(
          textCancel,
          style: rTheme().theme().dialogTheme.titleTextStyle?.copyWith(color: cancelTextColor),
        ),
      ));
    }
    if (textConfirm != null) {
      actions.add(TextButton(
        onPressed: onConfirm,
        child: Text(
          textConfirm,
          style: rTheme().theme().dialogTheme.titleTextStyle?.copyWith(color: confirmTextColor),
        ),
      ));
    }
    return actions;
  }
}
