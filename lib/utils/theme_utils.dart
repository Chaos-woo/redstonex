import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/resources/colours.dart';

class ThemeUtils {
  static void lightMode() {
    Get.changeTheme(ThemeData.light());
  }

  static void dartMode() {
    Get.changeTheme(ThemeData.dark());
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isDarkModeFastly() {
    if (Get.context != null) {
      return isDarkMode(Get.context!);
    } else {
      return false;
    }
  }

  static Color? getDarkColor(BuildContext context, Color darkColor) {
    return isDarkMode(context) ? darkColor : null;
  }

  static Color? getSecondaryTitleColor() {
    return isDarkModeFastly() ? Colours.darkTextGray : Colours.textGray;
  }

  static Color? getIconColor() {
    return isDarkModeFastly() ? Colours.darkText : null;
  }

  static Color getStickyHeaderColor() {
    return isDarkModeFastly() ? Colours.darkBgGray_ : Colours.bgGray_;
  }

  static Color getDialogTextFieldColor() {
    return isDarkModeFastly() ? Colours.darkText : Colours.text;
  }

  static Color? getKeyboardActionsColor() {
    return isDarkModeFastly() ? Colours.darkBgColor : Colors.grey[200];
  }

  static Color? getBgColor() {
    return isDarkModeFastly() ? Colours.darkBgColor : Colours.bgColor;
  }

  static Color? getBarrierColor() {
    return isDarkModeFastly() ? Colors.black38 : Colors.black54;
  }

  static ThemeData theme() {
    var theme = ThemeData.fallback();
    if (Get.context != null) {
      theme = Theme.of(Get.context!);
    }
    return theme;
  }

  /// 设置StatusBar、NavigationBar样式。(仅针对安卓)
// static void setSystemBarStyle({bool? isDark}) {
//   if (DeviceUtils.isAndroid) {
//
//     final bool isDarkMode = isDark ?? window.platformBrightness == Brightness.dark;
//     debugPrint('isDark: $isDarkMode');
//     final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//       /// 透明状态栏
//       statusBarColor: Colors.transparent,
//       systemNavigationBarColor: isDarkMode ? Colours.darkBgColor : Colors.white,
//       systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
//     );
//     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//   }
// }
}

extension ThemeExtension on BuildContext {
  bool get isDarkMode => ThemeUtils.isDarkMode(this);

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get dialogBackgroundColor => Theme.of(this).canvasColor;
}
