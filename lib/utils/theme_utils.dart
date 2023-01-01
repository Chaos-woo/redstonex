import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeUtils {
  static void setLightMode() {
    Get.changeTheme(ThemeData.light());
  }

  static void setDartMode() {
    Get.changeTheme(ThemeData.dark());
  }

  static bool isDarkMode() {
      if (Get.context != null) {
        return Theme.of(Get.context!).brightness == Brightness.dark;
      } else {
        return false;
      }
  }

  // static bool isDarkMode(BuildContext context) {
  //   return Theme.of(context).brightness == Brightness.dark;
  // }

  // static bool isDarkModeFastly() {
  //   if (Get.context != null) {
  //     return isDarkMode(Get.context!);
  //   } else {
  //     return false;
  //   }
  // }
  //
  // static Color? getDarkColor(BuildContext context, Color darkColor) {
  //   return isDarkMode(context) ? darkColor : null;
  // }
  //
  // static Color? getSecondaryTitleColor() {
  //   return isDarkModeFastly() ? Colours.darkTextGray : Colours.textGray;
  // }
  //
  // static Color? getIconColor() {
  //   return isDarkModeFastly() ? Colours.darkText : null;
  // }
  //
  // static Color getStickyHeaderColor() {
  //   return isDarkModeFastly() ? Colours.darkBgGray_ : Colours.bgGray_;
  // }
  //
  // static Color getDialogTextFieldColor() {
  //   return isDarkModeFastly() ? Colours.darkText : Colours.text;
  // }
  //

  static Color? getKeyboardActionsColor() {
    return isDarkMode() ? const Color(0xFF18191A) : Colors.grey[200];
  }

  //
  // static Color? getBgColor() {
  //   return isDarkModeFastly() ? Colours.darkBgColor : Colours.bgColor;
  // }
  //

  static Color? getBarrierColor() {
    return isDarkMode() ? Colors.black38 : Colors.black54;
  }

  static ThemeData theme() {
    var theme = ThemeData.fallback();
    if (Get.context != null) {
      theme = Theme.of(Get.context!);
    }
    return theme;
  }
}

extension ThemeExtension on BuildContext {
  bool get isDarkMode => ThemeUtils.isDarkMode();

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get dialogBackgroundColor => Theme.of(this).dialogBackgroundColor;
}
