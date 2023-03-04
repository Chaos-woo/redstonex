import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/exceptions/error_consts.dart';
import 'package:redstonex/exceptions/redstonex_exception.dart';
import 'package:redstonex/utils/screen.dart';

class XSnackBar {
  static final XSnackBar _single = XSnackBar._internal();

  XSnackBar._internal();

  factory XSnackBar() => _single;

  SnackbarController showPromptSnackBar({
    String? title,
    String? message,
    Duration? duration = const Duration(seconds: 3),
    Widget? icon,
    double borderRadius = 5.0,
    Color? borderColor,
    double? borderWidth,
    Color backgroundColor = const Color(0xFF303030),
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    EdgeInsets padding = const EdgeInsets.all(8),
    TextButton? lightButton,
    OnTap? onTapAny,

    /// snackBar的窗口状态回调
    SnackbarStatusCallback? snackBarStatusChanged,
  }) {
    return _innerShowElasticSnackBar(
      title: title,
      message: message,
      duration: duration,
      icon: icon,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      backgroundColor: backgroundColor,
      snackPosition: snackPosition,
      margin: margin,
      padding: padding,
      lightActions: lightButton,
      snackBarStatusChanged: snackBarStatusChanged,
      onTapAny: onTapAny,
    );
  }

  TextButton snackBarAction(String text, {TextStyle? textStyle, VoidCallback? onTap}) {
    TextStyle defaultStyle = const TextStyle(fontSize: 14, color: Colors.white);
    return TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: defaultStyle.merge(textStyle),
        ));
  }

  SnackbarController showElasticSnackBar({
    Widget? titleWidget,
    Widget? messageWidget,
    Widget? icon,
    Duration? duration = const Duration(seconds: 3),
    double borderRadius = 5.0,
    Color? borderColor,
    double? borderWidth,
    Color backgroundColor = const Color(0xFF303030),
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    EdgeInsets padding = const EdgeInsets.all(8),
    Widget? lightActions,
    SnackbarStatusCallback? snackBarStatusChanged,
    OnTap? onTapAny,
  }) {
    return _innerShowElasticSnackBar(
      titleWidget: titleWidget,
      messageWidget: messageWidget,
      icon: icon,
      duration: duration,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      backgroundColor: backgroundColor,
      snackPosition: snackPosition,
      margin: margin,
      padding: padding,
      lightActions: lightActions,
      snackBarStatusChanged: snackBarStatusChanged,
      onTapAny: onTapAny,
    );
  }

  SnackbarController _innerShowElasticSnackBar({
    String? title,
    String? message,
    Widget? titleWidget,
    Widget? messageWidget,
    Widget? icon,
    Duration? duration = const Duration(seconds: 3),
    double borderRadius = 5.0,
    Color? borderColor,
    double? borderWidth,
    Color backgroundColor = const Color(0xFF303030),
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    EdgeInsets padding = const EdgeInsets.all(8),
    Widget? lightActions,
    SnackbarStatusCallback? snackBarStatusChanged,
    OnTap? onTapAny,
  }) {
    if (title == null && message == null && titleWidget == null && messageWidget == null) {
      throw RsxInternalException.compose(XErrorCompose().common);
    }

    if (icon == null) {
      padding = const EdgeInsets.all(12);
    }

    if ((message != null && messageWidget == null) || (title != null && titleWidget == null)) {
      final iconPadding = padding.left > 16.0 ? padding.left : 0.0;
      double minWidth = XScreen().screenWidth - (margin.vertical + padding.vertical);
      if (icon != null) {
        minWidth -= iconPadding;
      }
      if (lightActions != null) {
        double buttonRightPadding = (padding.right - 12 < 0) ? 4 : padding.right - 12;
        minWidth -= buttonRightPadding;
      }

      int messageMaxLines = 2;
      if (message != null && messageWidget == null) {
        if (icon != null) messageMaxLines += 1;
        if (lightActions != null) messageMaxLines += 1;
        messageMaxLines = min(messageMaxLines, 3);

        /// style参考GetSnackBar源码
        TextSpan messageSpan = TextSpan(text: message, style: const TextStyle(fontSize: 14.0, color: Colors.white));
        TextPainter painter =
            TextPainter(text: messageSpan, maxLines: messageMaxLines, textDirection: TextDirection.rtl);
        double maxWidth = XScreen().screenWidth * 0.75;
        if (minWidth > maxWidth) {
          double tempWidth = maxWidth;
          maxWidth = minWidth;
          minWidth = tempWidth;
        }
        painter.layout(minWidth: minWidth, maxWidth: maxWidth);
        if (painter.didExceedMaxLines) {
          messageWidget = Text(
            message,
            style: const TextStyle(fontSize: 14.0, color: Colors.white),
            maxLines: messageMaxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
      }

      if (title != null && titleWidget == null) {
        int titleMaxLines = messageMaxLines == 3 ? 1 : 2;

        /// style参考GetSnackBar源码
        TextSpan titleSpan = TextSpan(
            text: message,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ));
        TextPainter painter = TextPainter(text: titleSpan, maxLines: titleMaxLines, textDirection: TextDirection.rtl);
        painter.layout(minWidth: minWidth, maxWidth: XScreen().screenWidth * 0.75);
        if (painter.didExceedMaxLines) {
          titleWidget = Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: titleMaxLines,
            overflow: TextOverflow.ellipsis,
          );
        }
      }
    }

    GetSnackBar snackBar = GetSnackBar(
      title: title,
      message: message,
      titleText: titleWidget,
      messageText: messageWidget,
      duration: duration,
      icon: icon,
      borderRadius: borderRadius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      backgroundColor: backgroundColor,
      snackPosition: snackPosition,
      margin: margin,
      padding: padding,
      mainButton: lightActions,
      snackbarStatus: snackBarStatusChanged,
      onTap: onTapAny,
    );
    return Get.showSnackbar(snackBar);
  }

  void closeCurrentSnackBar() {
    Get.closeCurrentSnackbar();
  }

  void closeAllSnackBar() {
    Get.closeAllSnackbars();
  }
}
