
import 'package:flutter/material.dart';

class MaterialDesign3 {
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
  final FontWeight weight;

  TextDimens(this.lineHeight, this.size, this.weight);

  TextStyle textStyle({String? fontFamily, Color? color}) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      fontFamily: fontFamily,
      color: color,
    );
  }
}