import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class XNetwork {
  static final XNetwork _single = XNetwork._internal();

  XNetwork._internal();

  factory XNetwork() => _single;

  /// 基础网络信息
  static final NetworkInfo _network = NetworkInfo();

  /// 网络连接信息
  static final Connectivity _connectivity = Connectivity();

  Future<String> wifiName() async => await _network.getWifiName() ?? '';

  Future<String> wifiIp() async => await _network.getWifiIP() ?? '';

  Future<bool> connected({bool bluetooth = false}) async {
    ConnectivityResult result = await connectivityResult();
    if (result == ConnectivityResult.bluetooth && bluetooth) {
      return true;
    }

    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  Future<ConnectivityResult> connectivityResult() async {
    return await _connectivity.checkConnectivity();
  }

  Future<bool> isWifi() async => ConnectivityResult.wifi == (await connectivityResult());

  Future<bool> isMobile() async => ConnectivityResult.mobile == (await connectivityResult());

  Future<bool> isEthernet() async => ConnectivityResult.ethernet == (await connectivityResult());

  Future<bool> isBluetooth() async => ConnectivityResult.bluetooth == (await connectivityResult());

  StreamSubscription onConnectivityChange(
    void Function(ConnectivityResult newStatus, bool connected) onChanged, {
    Function? onError,
    bool? cancelOnError,
    bool bluetooth = false,
  }) {
    return _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult newStatus) async {
        bool connected = await this.connected(bluetooth: bluetooth);
        onChanged(newStatus, connected);
      },
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }
}
