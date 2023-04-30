import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../redstonex.dart';
import 'theme.dart';

class XBottomSheet {
  static final XBottomSheet _single = XBottomSheet._internal();

  XBottomSheet._internal();

  factory XBottomSheet() => _single;

  showBottomSheet(
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
      barrierColor = barrierColor ?? XTheme().getBarrierColor();
    } else {
      backgroundColor = backgroundColor ?? Colors.white;
      barrierColor = barrierColor ?? XTheme().getBarrierColor();
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
