import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:example/homepage/common_tools/bottom_sheet_tools/bottom_sheet_tools_view.dart';
import 'package:example/homepage/common_tools/common_tools_state.dart';
import 'package:example/homepage/common_tools/dialog_tools/dialog_tools_view.dart';
import 'package:example/homepage/common_tools/snackbar_tools/snackbar_tools_view.dart';
import 'package:example/homepage/common_tools/toast_tools/toast_tools_view.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redstonex/redstonex.dart';

import 'common_tools_logic.dart';

class CommonToolsComponent extends StatelessWidget {
  late final CommonToolsLogic logic;
  late final CommonToolsState state;

  CommonToolsComponent({Key? key}) : super(key: key) {
    logic = Provides.provide(CommonToolsLogic());
    state = Depends.on<CommonToolsLogic>().state;
    _processNetworkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SnackbarToolsComponent(),
        Gaps.vGap10,
        DialogToolsComponent(),
        Gaps.vGap10,
        const ToastToolsComponent(),
        Gaps.vGap10,
        const BottomSheetToolsComponent(),
      ],
    );
  }

  Widget _buildDeviceInformation() {
    var android = DeviceUtils.androidInfo;
    String deviceInfo = '''
      Board: ${android.board}
      Brand: ${android.brand}
      Device: ${android.device}
      User display: ${android.display}
      Model: ${android.model}
      Manufacturer: ${android.manufacturer}
      Host: ${android.host}
      AndroidBuildVersion: 
        OS: ${android.version.baseOS}
        Code name: ${android.version.codename}
    ''';
    return ElevatedButton(
      onPressed: () => DialogUtils.showPromptDialog(
        title: 'Mobile device information',
        content: deviceInfo,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Icon(Icons.devices),
          Gaps.hGap4,
          Text('Device info'),
        ],
      ),
    );
  }

  Widget _buildApplicationInformation() {
    return ElevatedButton(
        onPressed: () => ToastUtils.show(
              'Show toast testing',
              position: ToastPosition.bottom,
            ),
        child: const Text('Toast'));
  }

  Widget _buildBottomSheet() {
    return ElevatedButton(
        onPressed: () => ToastUtils.show(
              'Show toast testing',
              position: ToastPosition.bottom,
            ),
        child: const Text('Toast'));
  }

  // Widget _buildNetworkInformation() {}

  void _processNetworkStatus() async {
    ConnectivityResult netConnectivityStatus = await NetUtils.connectivityResult();
    if (ConnectivityResult.none == netConnectivityStatus) {
      _toastNetStatusPrompt('网络连接已断开');
      state.netConnectivity = false;
    }
    NetUtils.listenConnectivityChange((ConnectivityResult newConnectivityStatus) async {
      bool netConnectivity = NetUtils.checkNetworkConnectivity(newConnectivityStatus);
      if (netConnectivity != state.netConnectivity) {
        state.netConnectivity = netConnectivity;
        if (netConnectivity) {
          _toastNetStatusPrompt('网络已连接');
        } else {
          _toastNetStatusPrompt('网络连接已断开');
        }
      }
    });
  }

  void _toastNetStatusPrompt(String promptTip) {
    ToastUtils.show(
      promptTip,
      position: ToastPosition.center,
    );
  }
}
