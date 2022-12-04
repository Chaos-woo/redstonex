import 'package:flutter/material.dart';

enum OptionGroupToolBarPosition { left, right }

class OptionGroupToolBar {
  String? title;
  Widget? tool;
  late OptionGroupToolBarPosition titlePosition;
  late OptionGroupToolBarPosition toolPosition;
  late bool titleFirst;

  OptionGroupToolBar({
    this.title,
    this.tool,
    this.titlePosition = OptionGroupToolBarPosition.left,
    this.toolPosition = OptionGroupToolBarPosition.left,
    this.titleFirst = true,
  });
}
