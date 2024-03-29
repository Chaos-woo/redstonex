import 'package:flutter/material.dart';
import 'package:get/get.dart';

class rTheme {
  static final rTheme _single = rTheme._internal();

  rTheme._internal();

  factory rTheme() => _single;

  void setLightMode(ThemeData theme) {
    Get.changeTheme(theme);
  }

  void setDartMode(ThemeData theme) {
    Get.changeTheme(theme);
  }

  bool isDarkMode() {
    if (Get.context != null) {
      return Theme.of(Get.context!).brightness == Brightness.dark;
    } else {
      return false;
    }
  }

  ThemeData theme() {
    var theme = ThemeData.fallback();
    if (Get.context != null) {
      theme = Theme.of(Get.context!);
    }
    return theme;
  }
}
