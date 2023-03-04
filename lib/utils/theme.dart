import 'package:flutter/material.dart';
import 'package:get/get.dart';

class XTheme {
  static final XTheme _single = XTheme._internal();

  XTheme._internal();

  factory XTheme() => _single;

  void setLightMode() {
    Get.changeTheme(ThemeData.light());
  }

  void setDartMode() {
    Get.changeTheme(ThemeData.dark());
  }

  bool isDarkMode() {
    if (Get.context != null) {
      return Theme.of(Get.context!).brightness == Brightness.dark;
    } else {
      return false;
    }
  }

  // bool isDarkMode(BuildContext context) {
  //   return Theme.of(context).brightness == Brightness.dark;
  // }

  // bool isDarkModeFastly() {
  //   if (Get.context != null) {
  //     return isDarkMode(Get.context!);
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Color? getDarkColor(BuildContext context, Color darkColor) {
  //   return isDarkMode(context) ? darkColor : null;
  // }
  //
  // Color? getSecondaryTitleColor() {
  //   return isDarkModeFastly() ? Colours.darkTextGray : Colours.textGray;
  // }
  //
  // Color? getIconColor() {
  //   return isDarkModeFastly() ? Colours.darkText : null;
  // }
  //
  // Color getStickyHeaderColor() {
  //   return isDarkModeFastly() ? Colours.darkBgGray_ : Colours.bgGray_;
  // }
  //
  // Color getDialogTextFieldColor() {
  //   return isDarkModeFastly() ? Colours.darkText : Colours.text;
  // }
  //

  Color? getKeyboardActionsColor() {
    return isDarkMode() ? const Color(0xFF18191A) : Colors.grey[200];
  }

  //
  // Color? getBgColor() {
  //   return isDarkModeFastly() ? Colours.darkBgColor : Colours.bgColor;
  // }
  //

  Color? getBarrierColor() {
    return isDarkMode() ? Colors.black38 : Colors.black54;
  }

  ThemeData theme() {
    var theme = ThemeData.fallback();
    if (Get.context != null) {
      theme = Theme.of(Get.context!);
    }
    return theme;
  }
}

extension ExtTheme on BuildContext {
  bool get isDarkMode => XTheme().isDarkMode();

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get dialogBackgroundColor => Theme.of(this).dialogBackgroundColor;
}
