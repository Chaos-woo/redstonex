import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  }) {
    if (Get.context != null) {
      backgroundColor = backgroundColor ?? ThemeUtils.getBgColor(Get.context!);
      barrierColor = barrierColor ?? ThemeUtils.getBarrierColor(Get.context!);
    }
    Get.bottomSheet(
      bottomSheet,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      ignoreSafeArea: ignoreSafeArea,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }
}
