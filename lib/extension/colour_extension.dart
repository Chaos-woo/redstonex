import 'package:flutter/material.dart';

extension ExtColour on Color {
  int toHex() {
    return value.toInt();
  }

  String toHexString() {
    return value.toRadixString(16);
  }

  RGB rgb() {
    return RGB(red, green, blue);
  }

  RGBO rgbo() {
    return RGBO(red, green, blue, opacity);
  }

  bool isLightColor(){
    double darkness =  1 - (0.299 * red + 0.587 * green + 0.114 * blue) / 255;
    return darkness<0.5;
  }
}

class RGB {
  final int red;
  final int green;
  final int blue;

  RGB(this.red, this.green, this.blue);

  List<int> get rgbArray => [red, green, blue];

  Color get color => Color.fromRGBO(red, green, blue, 1.0);
}

class RGBO {
  final int red;
  final int green;
  final int blue;
  final double opacity;

  RGBO(this.red, this.green, this.blue, this.opacity);

  List<int> get rgbArray => [red, green, blue];

  Color get color => Color.fromRGBO(red, green, blue, opacity);
}

