import 'package:flutter/material.dart';

class XShapeBorder {
  static final XShapeBorder _single = XShapeBorder._internal();

  XShapeBorder._internal();

  factory XShapeBorder() => _single;

  ShapeBorder roundedRectangleBorder({double radius = 0.0}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  ShapeBorder roundedRectangleBorderOnly({
    double topLeft = 0.0,
    double topRight = 0.0,
    double bottomLeft = 0.0,
    double bottomRight = 0.0,
  }) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
    );
  }
}
