import 'package:example/homepage/common_tools/bottom_sheet_tools/bottom_sheet_tools_view.dart';
import 'package:example/homepage/common_tools/common_tools_state.dart';
import 'package:example/homepage/common_tools/dialog_tools/dialog_tools_view.dart';
import 'package:example/homepage/common_tools/snackbar_tools/snackbar_tools_view.dart';
import 'package:example/homepage/common_tools/toast_tools/toast_tools_view.dart';
import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';

import 'common_tools_logic.dart';

class CommonToolsComponent extends StatelessWidget {
  late final CommonToolsLogic logic;
  late final CommonToolsState state;

  CommonToolsComponent({Key? key}) : super(key: key) {
    logic = rProvides().provide(CommonToolsLogic());
    state = rDepends().on<CommonToolsLogic>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SnackbarToolsComponent(),
        rGaps.vGap10,
        DialogToolsComponent(),
        rGaps.vGap10,
        const ToastToolsComponent(),
        rGaps.vGap10,
        BottomSheetToolsComponent(),
      ],
    );
  }
}
