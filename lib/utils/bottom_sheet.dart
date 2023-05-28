import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XBottomSheet {
  static final XBottomSheet _single = XBottomSheet._internal();

  XBottomSheet._internal();

  factory XBottomSheet() => _single;

  showBottomSheet(
    Widget child, {
    Color? backgroundColor,
    Color? barrierColor,
    bool ignoreSafeArea = true,
    bool customControlHeight = false, // 高度自定义控制，设置为true时需要child组件设置合适高度
    bool isDismissible = true, // 点击BottomSheet外部是否可关闭
    bool enableDrag = true, // 开启BottomSheet是否可拖拽
    ShapeBorder? shape,
    Duration? enterBottomSheetDuration,
    Duration? exitBottomSheetDuration,
  }) {
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
