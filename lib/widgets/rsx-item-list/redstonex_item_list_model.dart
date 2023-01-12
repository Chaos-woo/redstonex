import 'package:flutter/material.dart';

class RsxOptionGroupItem {
  final RsxHorizontalToolbar? toolbar;
  final List<RsxHorizontalItem> optionItems;

  RsxOptionGroupItem({required this.optionItems, this.toolbar});
}

enum RsxHorizontalToolbarPosition { left, right }

enum RsxHorizontalToolbarType { label, tool }

class RsxHorizontalToolbar {
  String? label;
  TextStyle? labelStyle;
  Widget? toolBuilder;
  RsxHorizontalToolbarPosition labelPosition;
  RsxHorizontalToolbarPosition toolPosition;
  RsxHorizontalToolbarType priorType;

  RsxHorizontalToolbar({
    this.label,
    this.labelStyle,
    this.toolBuilder,
    this.labelPosition = RsxHorizontalToolbarPosition.left,
    this.toolPosition = RsxHorizontalToolbarPosition.left,
    this.priorType = RsxHorizontalToolbarType.label,
  });
}

enum RsxHorizontalItemExtPosition { left, right }

class RsxHorizontalItem {
  String? title;
  TextStyle? titleStyle;
  Widget? titleWidget;
  Widget? description;
  Widget? extWidget;
  /// 根据实际的选项组件宽度，[extRatio]的值大于某个比例值时，位置的变化才会明显
  RsxHorizontalItemExtPosition? extWidgetPosition;
  /// 扩展组件与主内容组件宽度比例
  double? extRatio;
  Widget? leading;
  Widget? suffix;
  VoidCallback? onTap;
  VoidCallback? onDoubleTap;
  VoidCallback? onLongPress;
  BoxConstraints? constraints;
  BorderRadius? borderRadius;
  Color? backgroundColor;
  bool? leadingTop;

  RsxHorizontalItem({
    this.title,
    this.titleStyle,
    this.titleWidget,
    this.description,
    this.extWidget,
    this.extWidgetPosition = RsxHorizontalItemExtPosition.left,
    this.extRatio = 0.25,
    this.leading,
    this.suffix,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.constraints,
    this.borderRadius,
    this.backgroundColor,
    this.leadingTop = false,
  });
}