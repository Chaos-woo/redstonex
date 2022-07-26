import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetUtils {
  /// base network information
  static final NetworkInfo _net = NetworkInfo();

  /// network connectivity utils
  static final Connectivity _conn = Connectivity();

  /// Get wifi name
  static Future<String> wifiName() async => await _net.getWifiName() ?? '';

  /// Get wifi ip
  static Future<String> wifiIp() async => await _net.getWifiIP() ?? '';

  /// Check device connected network.
  ///
  /// [ConnectivityResult.bluetooth] is connected network when [bluetooth]
  /// parameter is `true` and connectivity result is [ConnectivityResult.bluetooth]
  ///
  static Future<bool> networkConnectivity({bool bluetooth = false}) async {
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

  static bool checkNetworkConnectivity(ConnectivityResult newConnectivity, {bool bluetooth = false}) {
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
  static Future<ConnectivityResult> connectivityResult() async {
    return await _conn.checkConnectivity();
  }

  /// Get connectivity type
  ///
  /// See also [ConnectivityResult]
  static Future<ConnectivityResult> connectivityType() async {
    return await connectivityResult();
  }

  /// Current connectivity whether wifi
  static Future<bool> isWifi() async => ConnectivityResult.wifi == (await connectivityResult());

  /// Current connectivity whether mobile
  static Future<bool> isMobile() async => ConnectivityResult.mobile == (await connectivityResult());

  /// Current connectivity whether ethernet
  static Future<bool> isEthernet() async => ConnectivityResult.ethernet == (await connectivityResult());

  /// Current connectivity whether bluetooth
  static Future<bool> isBluetooth() async => ConnectivityResult.bluetooth == (await connectivityResult());

  /// Listen connectivity changed
  ///
  /// If connectivity status changed, [onChanged] will get new status
  ///
  /// see also [Stream.listen]
  static StreamSubscription listenConnectivityChange(
    void Function(ConnectivityResult newConnectivityStatus) onChanged, {
    Function? onError,
    bool? cancelOnError,
  }) {
    return _conn.onConnectivityChanged.listen(
      (ConnectivityResult newConnectivityStatus) => onChanged,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }
}
