import 'dart:io';
import 'dart:math';

import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/widgets.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
///
/// bool isLandscape = Screen.isLandscape(context)
/// bool isLargePhone = Screen.diagonal(context) > 720;
/// bool isTablet = Screen.diagonalInches(context) >= 7;
/// bool isNarrow = Screen.widthInches(context) < 3.5;

class rScreen {
  static final rScreen _single = rScreen._internal();

  rScreen._internal();

  factory rScreen() => _single;

  double get screenHeight => ScreenUtil.getInstance().screenHeight;

  double get screenWidth => ScreenUtil.getInstance().screenWidth;

  double get _ppi => (Platform.isAndroid || Platform.isIOS) ? 150 : 96;

  bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;

  //PIXELS
  Size size(BuildContext context) => MediaQuery.of(context).size;

  double width(BuildContext context) => size(context).width;

  double height(BuildContext context) => size(context).height;

  double diagonal(BuildContext context) {
    final Size s = size(context);
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  Size inches(BuildContext context) {
    final Size pxSize = size(context);
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  double widthInches(BuildContext context) => inches(context).width;

  double heightInches(BuildContext context) => inches(context).height;

  double diagonalInches(BuildContext context) => diagonal(context) / _ppi;
}

extension MediaQueryExtension on BuildContext {
  Size get size => rScreen().size(this);

  double get screenHeight => rScreen().size(this).height;

  double get screenWidth => rScreen().size(this).width;

  double scaleHeight(double size) => ScreenUtil.getScaleH(this, size);

  double scaleWidth(double size) => ScreenUtil.getScaleW(this, size);

  double scaleSp(double size) => ScreenUtil.getScaleSp(this, size);
}
