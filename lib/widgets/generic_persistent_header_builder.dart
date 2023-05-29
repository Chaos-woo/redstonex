import 'package:flutter/material.dart';

/// 通用SliverPersistentHeader
class rGenericPersistentHeaderBuilder extends SliverPersistentHeaderDelegate {
  /// 最大高度
  final double maxHeight;

  /// 最小高度
  final double minHeight;

  /// 构造器
  final Widget Function(BuildContext context, double shrinkOffset, bool overlapsContent) builder;

  /// 初始化
  rGenericPersistentHeaderBuilder({
    this.maxHeight = 120,
    this.minHeight = 80,
    required this.builder,
  }) : assert(maxHeight >= minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant rGenericPersistentHeaderBuilder oldDelegate) =>
      maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || builder != oldDelegate.builder;
}
