import 'package:flutter/material.dart';

class Dimens {
  static const double fontSp10 = 10.0;
  static const double fontSp12 = 12.0;
  static const double fontSp14 = 14.0;
  static const double fontSp15 = 15.0;
  static const double fontSp16 = 16.0;
  static const double fontSp18 = 18.0;

  static const double gapDp4 = 4;
  static const double gapDp5 = 5;
  static const double gapDp8 = 8;
  static const double gapDp10 = 10;
  static const double gapDp12 = 12;
  static const double gapDp15 = 15;
  static const double gapDp16 = 16;
  static const double gapDp24 = 24;
  static const double gapDp32 = 32;
  static const double gapDp50 = 50;
}

class Md3Dimens {
  static TextDimens headlineLarge = TextDimens(40, 32, FontWeight.w400);
  static TextDimens headlineMedium = TextDimens(36, 28, FontWeight.w400);
  static TextDimens headlineSmall = TextDimens(32, 24, FontWeight.w400);

  static TextDimens titleLarge = TextDimens(28, 22, FontWeight.w400);
  static TextDimens titleMedium = TextDimens(24, 16, FontWeight.w500);
  static TextDimens titleSmall = TextDimens(20, 14, FontWeight.w500);

  static TextDimens labelLarge = TextDimens(20, 14, FontWeight.w500);
  static TextDimens labelMedium = TextDimens(16, 12, FontWeight.w500);
  static TextDimens labelSmall = TextDimens(16, 11, FontWeight.w500);

  static TextDimens bodyLarge = TextDimens(24, 16, FontWeight.w400);
  static TextDimens bodyMedium = TextDimens(20, 14, FontWeight.w400);
  static TextDimens bodySmall = TextDimens(16, 12, FontWeight.w400);
}

class TextDimens {
  final double lineHeight;
  final double size;
  final FontWeight widget;

  TextDimens(this.lineHeight, this.size, this.widget);

  TextStyle convertTextStyle({String? fontFamily, Color? color}) {
    return TextStyle(
      fontSize: size,
      fontWeight: widget,
      fontFamily: fontFamily,
      color: color,
    );
  }
}
