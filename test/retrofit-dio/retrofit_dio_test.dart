import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';
import 'package:redstonex/log/loggers.dart';
import 'package:redstonex/network-core/impls/dios.dart';
import 'package:redstonex/network-core/impls/self_dio.dart';
import 'package:test/test.dart';

import 'http_client_example.dart';

class MyGlobalHttpOptionConfigs extends GlobalHttpOptionConfigs {}

class MyGlobalConfigs extends GlobalConfig {
  @override
  GlobalHttpOptionConfigs get globalHttpOptionConfigs => MyGlobalHttpOptionConfigs();
}

void main() {
  test('http client test', () async {
    GlobalConfig global = MyGlobalConfigs();
    GlobalConfig.safeOverride(global);

    SelfDio selfDio = Dios.instance('https://');
    HttpClientExample httpClient = HttpClientExample(selfDio.dio, baseUrl: selfDio.baseUrl);
    final logger = Loggers.of();
    String string = await httpClient.getBaidu();
    logger.i(string);

    string = await httpClient.getBing();
    logger.i(string);
  });
}
