import 'package:flutter/material.dart';

import 'dimens.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class Gaps {
  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: Dimens.gapDp4);
  static const Widget hGap5 = SizedBox(width: Dimens.gapDp5);
  static const Widget hGap8 = SizedBox(width: Dimens.gapDp8);
  static const Widget hGap10 = SizedBox(width: Dimens.gapDp10);
  static const Widget hGap12 = SizedBox(width: Dimens.gapDp12);
  static const Widget hGap15 = SizedBox(width: Dimens.gapDp15);
  static const Widget hGap16 = SizedBox(width: Dimens.gapDp16);
  static const Widget hGap32 = SizedBox(width: Dimens.gapDp32);

  static Widget hGap(double width) {
    return SizedBox(width: width);
  }

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: Dimens.gapDp4);
  static const Widget vGap5 = SizedBox(height: Dimens.gapDp5);
  static const Widget vGap8 = SizedBox(height: Dimens.gapDp8);
  static const Widget vGap10 = SizedBox(height: Dimens.gapDp10);
  static const Widget vGap12 = SizedBox(height: Dimens.gapDp12);
  static const Widget vGap15 = SizedBox(height: Dimens.gapDp15);
  static const Widget vGap16 = SizedBox(height: Dimens.gapDp16);
  static const Widget vGap24 = SizedBox(height: Dimens.gapDp24);
  static const Widget vGap32 = SizedBox(height: Dimens.gapDp32);
  static const Widget vGap50 = SizedBox(height: Dimens.gapDp50);

  static Widget vGap(double height) {
    return SizedBox(height: height);
  }

  static const Widget line = Divider();

  static Widget vLine({double width = 0.6, double height = 24.0}) {
    return SizedBox(
      width: width,
      height: height,
      child: const VerticalDivider(),
    );
  }

  static const Widget emptyBox = SizedBox.shrink();
}
