import 'package:flutter/material.dart';
import 'package:redstonex/extension/string_extension.dart';
import 'package:redstonex/resources/gaps.dart';
import 'package:redstonex/widgets/rsx-item-list/redstonex_item_list_model.dart';
import 'package:styled_widget/styled_widget.dart';

class RsxHorizontalToolbarWidget extends StatelessWidget {
  final RsxHorizontalToolbar? toolbar;

  const RsxHorizontalToolbarWidget({
    Key? key,
    required this.toolbar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (null == toolbar) {
      return Gaps.emptyBox;
    }

    var labelPos = toolbar!.labelPosition;
    var toolPos = toolbar!.toolPosition;
    RsxHorizontalToolbarPosition targetLeftPos = RsxHorizontalToolbarPosition.left;
    var labelWidget = toolbar!.label.oNullOrBlank ? Gaps.emptyBox : Text(toolbar!.label!, style: toolbar!.labelStyle);
    var toolWidget = null == toolbar!.toolBuilder ? Gaps.emptyBox : toolbar!.toolBuilder!;
    var toolbarRow = <Widget>[];
    if (labelPos != toolPos) {
      if (_checkPosition(labelPos, targetLeftPos)) {
        toolbarRow = <Widget>[labelWidget, const Spacer(), toolWidget];
      } else {
        toolbarRow = <Widget>[toolWidget, const Spacer(), labelWidget];
      }
    } else {
      if (_checkPosition(labelPos, targetLeftPos) && _checkPosition(toolPos, targetLeftPos)) {
        if (RsxHorizontalToolbarType.label == toolbar!.priorType) {
          toolbarRow = <Widget>[labelWidget, toolWidget, const Spacer()];
        } else {
          toolbarRow = <Widget>[toolWidget, labelWidget, const Spacer()];
        }
      } else {
        if (RsxHorizontalToolbarType.label == toolbar!.priorType) {
          toolbarRow = <Widget>[const Spacer(), labelWidget, toolWidget];
        } else {
          toolbarRow = <Widget>[const Spacer(), toolWidget, labelWidget];
        }
      }
    }

    return toolbarRow.toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center);
  }

  bool _checkPosition(RsxHorizontalToolbarPosition position, RsxHorizontalToolbarPosition targetPosition) {
    return position == targetPosition;
  }
}
