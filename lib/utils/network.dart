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

  /// Check device connected network.
  ///
  /// [ConnectivityResult.bluetooth] is connected network when [bluetooth]
  /// parameter is `true` and connectivity result is [ConnectivityResult.bluetooth]
  ///
  Future<bool> networkConnectivity({bool bluetooth = false}) async {
    ConnectivityResult result = await connectivityResult();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet) {
      return Future.value(true);
    } else if (result == ConnectivityResult.bluetooth && bluetooth) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  bool checkNetworkConnectivity(ConnectivityResult newConnectivity, {bool bluetooth = false}) {
    if (newConnectivity == ConnectivityResult.wifi ||
        newConnectivity == ConnectivityResult.mobile ||
        newConnectivity == ConnectivityResult.ethernet) {
      return true;
    } else if (newConnectivity == ConnectivityResult.bluetooth && bluetooth) {
      return true;
    } else {
      return false;
    }
  }

  /// Get connectivity result
  Future<ConnectivityResult> connectivityResult() async {
    return await _connectivity.checkConnectivity();
  }

  /// Get connectivity type
  ///
  /// See also [ConnectivityResult]
  Future<ConnectivityResult> connectivityType() async {
    return await connectivityResult();
  }

  /// Current connectivity whether wifi
  Future<bool> isWifi() async => ConnectivityResult.wifi == (await connectivityResult());

  /// Current connectivity whether mobile
  Future<bool> isMobile() async => ConnectivityResult.mobile == (await connectivityResult());

  /// Current connectivity whether ethernet
  Future<bool> isEthernet() async => ConnectivityResult.ethernet == (await connectivityResult());

  /// Current connectivity whether bluetooth
  Future<bool> isBluetooth() async => ConnectivityResult.bluetooth == (await connectivityResult());

  /// Listen connectivity changed
  ///
  /// If connectivity status changed, [onChanged] will get new status
  ///
  /// see also [Stream.listen]
  StreamSubscription listenConnectivityChange(
    void Function(ConnectivityResult newConnectivityStatus) onChanged, {
    Function? onError,
    bool? cancelOnError,
  }) {
    return _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult newConnectivityStatus) => onChanged,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }
}
