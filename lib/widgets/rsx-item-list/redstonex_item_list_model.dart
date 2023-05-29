import 'package:flutter/material.dart';

class rOptionGroupItem {
  final rHorizontalToolbar? toolbar;
  final List<rHorizontalItem> optionItems;

  rOptionGroupItem({required this.optionItems, this.toolbar});
}

enum rHorizontalToolbarPosition { left, right }

enum rHorizontalToolbarType { label, tool }

class rHorizontalToolbar {
  String? label;
  TextStyle? labelStyle;
  Widget? toolBuilder;
  rHorizontalToolbarPosition labelPosition;
  rHorizontalToolbarPosition toolPosition;
  rHorizontalToolbarType priorType;

  rHorizontalToolbar({
    this.label,
    this.labelStyle,
    this.toolBuilder,
    this.labelPosition = rHorizontalToolbarPosition.left,
    this.toolPosition = rHorizontalToolbarPosition.left,
    this.priorType = rHorizontalToolbarType.label,
  });
}

enum rHorizontalItemExtPosition { left, right }

class rHorizontalItem {
  String? title;
  TextStyle? titleStyle;
  Widget? titleWidget;
  Widget? description;
  Widget? extWidget;
  /// 根据实际的选项组件宽度，[extRatio]的值大于某个比例值时，位置的变化才会明显
  rHorizontalItemExtPosition? extWidgetPosition;
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

  rHorizontalItem({
    this.title,
    this.titleStyle,
    this.titleWidget,
    this.description,
    this.extWidget,
    this.extWidgetPosition = rHorizontalItemExtPosition.left,
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