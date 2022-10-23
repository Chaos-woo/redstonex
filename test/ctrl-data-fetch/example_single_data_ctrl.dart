import 'package:get/get.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/log/loggers.dart';
import 'package:redstonex/network-core/impls/dios.dart';
import 'package:redstonex/network-core/impls/self_dio.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/single_data_view_ctrl.dart';
import 'package:test/test.dart';

import '../retrofit-dio/http_client_example.dart';
import '../retrofit-dio/retrofit_dio_test.dart';

/// Test single data view ctrl, if need real needed
/// data is not `String`, you can implement [onLoadingCompleted]
/// to translate any you want.
///
class ExampleSingleDataCtrl extends SingleDataViewCtrl<String> implements GetxService {
  final _logger = Loggers.of();

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
    SelfDio selfDio = Dios.instance('https://');
    HttpClientExample httpClient = HttpClientExample(selfDio.dio, baseUrl: selfDio.baseUrl);
    final logger = Loggers.of();
    String string = await httpClient.getBaidu();
    logger.i(string);
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
