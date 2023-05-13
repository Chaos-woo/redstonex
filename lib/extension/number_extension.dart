import 'package:flutter/widgets.dart';

extension ExtInt on int {
  Duration get days => Duration(days: this);

  Duration get hours => Duration(hours: this);

  Duration get minutes => Duration(minutes: this);

  Duration get seconds => Duration(seconds: this);

  Duration get milliseconds => Duration(milliseconds: this);

  Duration get microseconds => Duration(microseconds: this);
}

extension ExtDouble on double {
  EdgeInsetsGeometry get leftEdge => EdgeInsets.only(left: this);

  EdgeInsetsGeometry get leftTopEdge => EdgeInsets.only(left: this, top: this);

  EdgeInsetsGeometry get leftBottomEdge => EdgeInsets.only(left: this, bottom: this);

  EdgeInsetsGeometry get rightEdge => EdgeInsets.only(right: this);

  EdgeInsetsGeometry get rightTopEdge => EdgeInsets.only(right: this, top: this);

  EdgeInsetsGeometry get rightBottomEdge => EdgeInsets.only(right: this, bottom: this);

  EdgeInsetsGeometry get topEdge => EdgeInsets.only(top: this);

  EdgeInsetsGeometry get bottomEdge => EdgeInsets.only(bottom: this);

  EdgeInsetsGeometry get verticalEdge => EdgeInsets.symmetric(vertical: this);

  EdgeInsetsGeometry get horizontalEdge => EdgeInsets.symmetric(horizontal: this);

  EdgeInsetsGeometry get allEdge => EdgeInsets.symmetric(vertical: this, horizontal: this);
}
