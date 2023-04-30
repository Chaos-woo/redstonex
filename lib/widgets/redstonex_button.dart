import 'package:flutter/material.dart';

import '../resources/dimens.dart';
import '../utils/theme.dart';

class RsxTextButton extends StatelessWidget {
  RsxTextButton({
    Key? key,
    this.text = '',
    this.fontSize = Dimens.fontSp18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor = Colors.transparent,
    this.disabledBackgroundColor,
    this.onPressed,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius,
    this.side = BorderSide.none,
  }) : super(key: key);

  String text;
  double fontSize;
  Color? textColor;
  Color? disabledTextColor;
  Color? backgroundColor;
  Color? disabledBackgroundColor;
  double? minHeight;
  double? minWidth;
  VoidCallback? onPressed;
  EdgeInsetsGeometry padding;
  double? radius;
  BorderSide? side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = XTheme().isDarkMode();
    ThemeData themeData = XTheme().theme();
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // 文字颜色
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledTextColor ?? themeData.disabledColor;
              }
              return textColor ?? themeData.textTheme.button?.color;
            },
          ),
          // 背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledBackgroundColor ?? themeData.unselectedWidgetColor;
            }
            return backgroundColor ?? themeData.buttonTheme.colorScheme?.background;
          }),
          // 水波纹
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return (textColor ?? (isDark ? themeData.backgroundColor : Colors.white))
                .withOpacity(0.12);
          }),
          // 按钮最小大小
          minimumSize: (minWidth == null || minHeight == null)
              ? null
              : MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
          shape: radius != null
              ? MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius!),
                  ),
                )
              : null,
          side: side != null ? MaterialStateProperty.all<BorderSide>(side!) : null,
        ),
        child: Text(text, style: TextStyle(fontSize: fontSize)));
  }
}

class RsxElevatedButton extends StatelessWidget {
  RsxElevatedButton({
    Key? key,
    this.text = '',
    this.fontSize = Dimens.fontSp18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.onPressed,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius,
    this.side = BorderSide.none,
  }) : super(key: key);

  String text;
  double fontSize;
  Color? textColor;
  Color? disabledTextColor;
  Color? backgroundColor;
  Color? disabledBackgroundColor;
  double? minHeight;
  double? minWidth;
  VoidCallback? onPressed;
  EdgeInsetsGeometry padding;
  double? radius;
  BorderSide? side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = XTheme().isDarkMode();
    ThemeData themeData = XTheme().theme();
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // 文字颜色
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return disabledTextColor ?? themeData.disabledColor;
              }
              return textColor ?? themeData.textTheme.button?.color;
            },
          ),
          // 背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledBackgroundColor ?? themeData.unselectedWidgetColor;
            }
            return backgroundColor ?? themeData.buttonTheme.colorScheme?.background;
          }),
          // 水波纹
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return (textColor ?? (isDark ? themeData.backgroundColor : Colors.white))
                .withOpacity(0.12);
          }),
          // 按钮最小大小
          minimumSize: (minWidth == null || minHeight == null)
              ? null
              : MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
          shape: radius != null
              ? MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius!),
                  ),
                )
              : null,
          side: side != null ? MaterialStateProperty.all<BorderSide>(side!) : null,
        ),
        child: Text(text, style: TextStyle(fontSize: fontSize)));
  }
}
