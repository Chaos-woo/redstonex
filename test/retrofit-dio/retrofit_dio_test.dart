import 'package:dio/dio.dart';
import 'package:redstonex/ioc-core/self_reflectable.dart';
import 'package:test/test.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/commons/log/redstone_logger.dart';
import 'package:redstonex/network-core/definitions/proxy/dios.dart';

import 'http_client_example.dart';

class MyGlobalHttpOptionConfigs extends GlobalHttpOptionConfigs {
  /// auto insert log interceptor for dio
  @override
  bool get enableAutoLogInterceptor => true;

  /// whether enable publish loading event when http request
  @override
  bool get enableHttpLoadingEventPublish => true;

  /// enable request context log
  @override
  bool get enableRequestContextInterceptor => true;
}

class MyGlobalConfigs extends GlobalConfig {
  @override
  GlobalHttpOptionConfigs get globalHttpOptionConfigs => MyGlobalHttpOptionConfigs();
}

void main() {
  test('http client test', () async {
    GlobalConfig global = MyGlobalConfigs();
    GlobalConfig.safeOverride(global);

    Dio dio = Dios.of();
    HttpClientExample httpClient = HttpClientExample(dio, baseUrl: 'https://');
    RedstoneLogger logger = Loggers.of();
    String string = await httpClient.getBaidu();
    logger.i(string);
  });
}
