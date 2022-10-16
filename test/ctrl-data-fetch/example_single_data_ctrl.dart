import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:get/get.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/commons/log/redstone_logger.dart';
import 'package:redstonex/network-core/definitions/proxy/dios.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/single_data_view_ctrl.dart';

import '../retrofit-dio/http_client_example.dart';
import '../retrofit-dio/retrofit_dio_test.dart';

/// Test single data view ctrl, if need real needed
/// data is not `String`, you can implement [onLoadingCompleted]
/// to translate any you want.
///
class ExampleSingleDataCtrl extends SingleDataViewCtrl<String> implements GetxService {
  final RedstoneLogger _logger = Loggers.of();

  String builtInString = '';

  ExampleSingleDataCtrl();

  @override
  void initialCtrlStatus() {
    _logger.i('initial ctrl status');
  }

  @override
  void onPreLoading() {
    _logger.i('load data pre');
  }

  @override
  Future<String?> onFetchingData() async {
    Dio dio = Dios.of();
    HttpClientExample httpClient = HttpClientExample(dio, baseUrl: 'https://');
    String string = await httpClient.getBaidu();
    _logger.i(string);
    return string;
  }

  @override
  void onLoadingCompleted(String? obtainedData) {
    _logger.i('secondary process: $obtainedData');
    builtInString = obtainedData ?? '';
  }

  void logAny(String any) => _logger.i(any);
}

void main() {
  test('ctrl single data test', () async {
    GlobalConfig global = MyGlobalConfigs();
    GlobalConfig.safeOverride(global);
    ExampleSingleDataCtrl ctrl = ExampleSingleDataCtrl();

    await ctrl.testViewCtrlInitialReady();
  });
}
