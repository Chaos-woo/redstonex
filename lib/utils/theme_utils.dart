import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/res/colours.dart';

class ThemeUtils {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool isDarkFastly() {
    if (Get.context != null) {
      return isDark(Get.context!);
    } else {
      return false;
    }
  }

  static Color? getSecondaryTitleColor() {
    return isDarkFastly() ? Colours.darkTextGray : Colours.textGray;
  }

  static Color? getDarkColor(BuildContext context, Color darkColor) {
    return isDark(context) ? darkColor : null;
  }

  static Color? getIconColor(BuildContext context) {
    return isDark(context) ? Colours.darkText : null;
  }

  static Color getStickyHeaderColor(BuildContext context) {
    return isDark(context) ? Colours.darkBgGray_ : Colours.bgGray_;
  }

  static Color getDialogTextFieldColor(BuildContext context) {
    return isDark(context) ? Colours.darkBgGray_ : Colours.bgGray;
  }

  static Color? getKeyboardActionsColor(BuildContext context) {
    return isDark(context) ? Colours.darkBgColor : Colors.grey[200];
  }

  static Color? getBgColor(BuildContext context) {
    return isDark(context) ? Colours.darkBgColor : Colours.bgColor;
  }

  static Color? getBarrierColor(BuildContext context) {
    return isDark(context) ? Colors.black38 : Colors.black54;
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
  bool get isDark => ThemeUtils.isDark(this);

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get dialogBackgroundColor => Theme.of(this).canvasColor;
}
