import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/utils/theme_utils.dart';

class BottomSheetUtils {
  static showBottomSheet(
    Widget child, {
    Color? backgroundColor,
    Color? barrierColor,
    bool ignoreSafeArea = true,
    /// 高度自定义控制，设置为true时需要child组件设置合适高度
    bool customControlHeight = false,
    bool isDismissible = true,
    bool enableDrag = true,
    ShapeBorder? shape,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
  }) {
    if (Get.context != null) {
      backgroundColor = backgroundColor ?? Colors.white;
      barrierColor = barrierColor ?? ThemeUtils.getBarrierColor();
    } else {
      backgroundColor = backgroundColor ?? Colors.white;
      barrierColor = barrierColor ?? ThemeUtils.getBarrierColor();
    }

    Get.bottomSheet(
      child,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      ignoreSafeArea: ignoreSafeArea,
      isScrollControlled: customControlHeight,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: shape,
      enterBottomSheetDuration: enterBottomSheetDuration,
      exitBottomSheetDuration: exitBottomSheetDuration,
    );
  }
}
