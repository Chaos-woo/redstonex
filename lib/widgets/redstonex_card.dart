import 'package:flutter/material.dart';
import 'package:redstonex/resources/colours.dart';
import 'package:redstonex/utils/theme_utils.dart';

class RsxCard extends StatelessWidget {
  const RsxCard({super.key, required this.child, this.color, this.shadowColor});

  final Widget child;
  final Color? color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDarkMode;

    final Color backgroundColor = color ?? (isDark ? Colours.darkBgGray_ : Colors.white);
    final Color sColor = isDark ? Colors.transparent : (shadowColor ?? const Color(0x80DCE7FA));

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(color: sColor, offset: const Offset(0.0, 2.0), blurRadius: 8.0),
        ],
      ),
      child: child,
    );
  }
}
