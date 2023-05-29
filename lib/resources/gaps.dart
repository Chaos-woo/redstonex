import 'package:flutter/material.dart';

import 'dimens.dart';

/// 间隔
/// 官方做法：https://github.com/flutter/flutter/pull/54394
class rGaps {
  /// 水平间隔
  static const Widget hGap4 = SizedBox(width: rDimens.gapDp4);
  static const Widget hGap5 = SizedBox(width: rDimens.gapDp5);
  static const Widget hGap8 = SizedBox(width: rDimens.gapDp8);
  static const Widget hGap10 = SizedBox(width: rDimens.gapDp10);
  static const Widget hGap12 = SizedBox(width: rDimens.gapDp12);
  static const Widget hGap15 = SizedBox(width: rDimens.gapDp15);
  static const Widget hGap16 = SizedBox(width: rDimens.gapDp16);
  static const Widget hGap32 = SizedBox(width: rDimens.gapDp32);

  static Widget hGap(double width) {
    return SizedBox(width: width);
  }

  /// 垂直间隔
  static const Widget vGap4 = SizedBox(height: rDimens.gapDp4);
  static const Widget vGap5 = SizedBox(height: rDimens.gapDp5);
  static const Widget vGap8 = SizedBox(height: rDimens.gapDp8);
  static const Widget vGap10 = SizedBox(height: rDimens.gapDp10);
  static const Widget vGap12 = SizedBox(height: rDimens.gapDp12);
  static const Widget vGap15 = SizedBox(height: rDimens.gapDp15);
  static const Widget vGap16 = SizedBox(height: rDimens.gapDp16);
  static const Widget vGap24 = SizedBox(height: rDimens.gapDp24);
  static const Widget vGap32 = SizedBox(height: rDimens.gapDp32);
  static const Widget vGap50 = SizedBox(height: rDimens.gapDp50);

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
