import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redstonex/redstonex.dart';
import 'package:redstonex/resources/colours.dart';

/// Toast工具类
class ToastUtils {
  static void show(
    String? msg, {
    IconData? icon,
    double iconSize = 24,
    Color iconColor = Colors.white,
    int duration = 2000,
    ToastPosition? position = ToastPosition.bottom,
    Color? backgroundColor = Colours.darkBgColor,
    double radius = 10.0,
    VoidCallback? onDismiss,
    EdgeInsetsGeometry? textPadding = const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
    EdgeInsetsGeometry? margin = const EdgeInsets.all(50),
    TextAlign? textAlign,
    TextStyle? textStyle,
    int? textMaxLines = 2,
    TextOverflow? textOverflow = TextOverflow.ellipsis,
  }) {
    if (msg == null) {
      return;
    }

    if (icon != null) {
      final Widget widget = Container(
        margin: margin,
        padding: textPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        child: ClipRect(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: iconColor, size: iconSize),
              Gaps.hGap4,
              Flexible(child:               Text(
                msg,
                style: textStyle,
                textAlign: textAlign,
                maxLines: textMaxLines,
                overflow: textOverflow,
                softWrap: true,
              )),
            ],
          ),
        ),
      );
      showToastWidget(
        widget,
        duration: Duration(milliseconds: duration),
        dismissOtherToast: true,
        position: position,
        onDismiss: onDismiss,
      );
      return;
    }

    showToast(
      msg,
      duration: Duration(milliseconds: duration),
      dismissOtherToast: true,
      position: position,
      backgroundColor: backgroundColor,
      radius: radius,
      onDismiss: onDismiss,
      textPadding: textPadding,
      textAlign: textAlign,
      textStyle: textStyle,
      textMaxLines: textMaxLines,
      textOverflow: textOverflow,
    );
  }

  static void cancelToast() {
    dismissAllToast();
  }
}
