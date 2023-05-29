import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../extension/string_extension.dart';
import '../../resources/gaps.dart';
import 'redstonex_item_list_model.dart';

class rHorizontalToolbarWidget extends StatelessWidget {
  final rHorizontalToolbar? toolbar;

  const rHorizontalToolbarWidget({
    Key? key,
    required this.toolbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (null == toolbar) {
      return rGaps.emptyBox;
    }

    var labelPos = toolbar!.labelPosition;
    var toolPos = toolbar!.toolPosition;
    rHorizontalToolbarPosition targetLeftPos = rHorizontalToolbarPosition.left;
    var labelWidget = toolbar!.label.oNullOrBlank
        ? rGaps.emptyBox
        : Text(toolbar!.label!, style: toolbar!.labelStyle);
    var toolWidget = null == toolbar!.toolBuilder ? rGaps.emptyBox : toolbar!.toolBuilder!;
    var toolbarRow = <Widget>[];
    if (labelPos != toolPos) {
      if (_checkPosition(labelPos, targetLeftPos)) {
        toolbarRow = <Widget>[labelWidget, const Spacer(), toolWidget];
      } else {
        toolbarRow = <Widget>[toolWidget, const Spacer(), labelWidget];
      }
    } else {
      if (_checkPosition(labelPos, targetLeftPos) && _checkPosition(toolPos, targetLeftPos)) {
        if (rHorizontalToolbarType.label == toolbar!.priorType) {
          toolbarRow = <Widget>[labelWidget, toolWidget, const Spacer()];
        } else {
          toolbarRow = <Widget>[toolWidget, labelWidget, const Spacer()];
        }
      } else {
        if (rHorizontalToolbarType.label == toolbar!.priorType) {
          toolbarRow = <Widget>[const Spacer(), labelWidget, toolWidget];
        } else {
          toolbarRow = <Widget>[const Spacer(), toolWidget, labelWidget];
        }
      }
    }

    return toolbarRow.toRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center);
  }

  bool _checkPosition(
      rHorizontalToolbarPosition position, rHorizontalToolbarPosition targetPosition) {
    return position == targetPosition;
  }
}
