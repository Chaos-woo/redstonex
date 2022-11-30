import 'package:flutter/material.dart';
import 'package:redstonex/res/colours.dart';
import 'package:redstonex/res/dimens.dart';
import 'package:redstonex/utils/theme_utils.dart';

class RsxButton extends StatelessWidget {

  const RsxButton({
    super.key,
    this.text = '',
    this.fontSize = Dimens.fontSp18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 2.0,
    this.side = BorderSide.none,
    required this.onPressed,
  });

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? minHeight;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // 文字颜色
        foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledTextColor ?? (isDark ? Colours.darkTextDisabled : Colours.textDisabled);
            }
            return textColor ?? (isDark ? Colours.darkButtonText : Colors.white);
          },
        ),
        // 背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return disabledBackgroundColor ?? (isDark ? Colours.darkButtonDisabled : Colours.buttonDisabled);
          }
          return backgroundColor ?? (isDark ? Colours.darkAppBaseMain : Colours.appBaseMain);
        }),
        // 水波纹
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return (textColor ?? (isDark ? Colours.darkButtonText : Colors.white)).withOpacity(0.12);
        }),
        // 按钮最小大小
        minimumSize: (minWidth == null || minHeight == null) ? null : MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(side),
      ),
      child: Text(text, style: TextStyle(fontSize: fontSize),)
    );
  }
}
