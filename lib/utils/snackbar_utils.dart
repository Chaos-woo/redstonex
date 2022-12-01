import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarUtils {
  static SnackbarController showPromptSnackBar({
    String? title,
    String? message,
    Duration? duration = const Duration(seconds: 3),
    Color? textColor,
    double? borderRadius,
    Color? borderColor,
    double? borderWidth,
    Color? backgroundColor,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    EdgeInsets? margin = const EdgeInsets.symmetric(horizontal: 10),
    EdgeInsets? padding = const EdgeInsets.all(16),
    TextButton? lightButton,
    OnTap? onTapAny,
    /// snackBar的窗口状态回调
    SnackbarStatusCallback? snackbarStatus,
  }) {
    return Get.snackbar(title ?? '', message ?? '',
        duration: duration,
        colorText: textColor,
        borderRadius: borderRadius,
        borderColor: borderColor,
        borderWidth: borderWidth,
        backgroundColor: backgroundColor,
        snackPosition: snackPosition,
        margin: margin,
        padding: padding,
        mainButton: lightButton,
        onTap: onTapAny,
        snackbarStatus: snackbarStatus
    );
  }

  static SnackbarController showElasticSnackBar({
    String? title,
    String? message,
    Widget? titleWidget,
    Widget? messageWidget,
    Widget? icon,
    Duration? duration = const Duration(seconds: 3),
    double borderRadius = 0.0,
    Color? borderColor,
    double? borderWidth,
    Color backgroundColor = const Color(0xFF303030),
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 10),
    EdgeInsets padding = const EdgeInsets.all(16),
    Widget? lightActions,
    OnTap? onTapAny,
  }) {
    var leanTitleWidget = titleWidget != null ? true : false;
    var leanMessageWidget = titleWidget != null ? true : false;
    GetSnackBar snackBar = GetSnackBar(
      title: leanTitleWidget ? '' : title ?? '',
      message: leanMessageWidget ? '' : message ?? '',
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
      onTap: onTapAny,
    );
    return Get.showSnackbar(snackBar);
  }
}
