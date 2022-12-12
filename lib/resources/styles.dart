import 'package:flutter/material.dart';
import 'package:redstonex/resources/colours.dart';
import 'package:redstonex/resources/dimens.dart';

class TextStyles {
  
  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.fontSp12,
  );
  static const TextStyle textSize14 = TextStyle(
    fontSize: Dimens.fontSp14,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.fontSp16,
  );
  static const TextStyle textBold14 = TextStyle(
    fontSize: Dimens.fontSp14,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = TextStyle(
    fontSize: Dimens.fontSp16,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = TextStyle(
    fontSize: Dimens.fontSp18,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold
  );
 
  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.fontSp14,
    color: Colours.textGray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.fontSp14,
    color: Colours.darkTextGray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.fontSp14,
    color: Colours.white12,
  );
  
  static const TextStyle text = TextStyle(
    fontSize: Dimens.fontSp14,
    color: Colours.text,
    // https://github.com/flutter/flutter/issues/40248
    textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textDark = TextStyle(
    fontSize: Dimens.fontSp14,
    color: Colours.darkText,
    textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textGray12 = TextStyle(
    fontSize: Dimens.fontSp12,
    color: Colours.textGray,
    fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = TextStyle(
    fontSize: Dimens.fontSp12,
    color: Colours.darkTextGray,
    fontWeight: FontWeight.normal
  );
  
  static const TextStyle textHint14 = TextStyle(
    fontSize: Dimens.fontSp14,
    color: Colours.darkUnselectedItemColor
  );
}
