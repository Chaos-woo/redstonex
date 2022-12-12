import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/resources/colours.dart';
import 'package:redstonex/utils/theme_utils.dart';

class BottomSheetUtils {
  static showBottomSheet(
    Widget bottomSheet, {
    Color? backgroundColor,
    Color? barrierColor,
    bool ignoreSafeArea = true,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    ShapeBorder? shape,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
  }) {
    if (Get.context != null) {
      backgroundColor = backgroundColor ?? ThemeUtils.getBgColor();
      barrierColor = barrierColor ?? ThemeUtils.getBarrierColor();
    } else {
      backgroundColor = backgroundColor ?? Colors.white;
      barrierColor = barrierColor ?? Colours.darkBgColor;
    }
    Get.bottomSheet(
      bottomSheet,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      ignoreSafeArea: ignoreSafeArea,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: shape,
    );
  }

  static ShapeBorder roundedTopLRRadius({double radius = 20.0}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
    );
  }
}
