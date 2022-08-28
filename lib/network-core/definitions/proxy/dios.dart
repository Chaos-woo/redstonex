import 'package:dio/dio.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/commons/standards/of_syntax.dart';
import 'package:redstonex/network-core/definitions/http/redstone_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/built_in_interceptors.dart';
import 'package:redstonex/network-core/definitions/proxy/redstone_dio.dart';
import 'package:redstonex/network-core/definitions/proxy/redstone_dio_option.dart';

/// A Dio configuration creator.
///
class Dios with OfSyntax {
  /// fixed redstone dio name
  static const String _fixedRedStoneXDioName = '_fixedRedStoneXDio';

  /// named dio instance map
  static final Map<String, RedStoneDio> _dios = {};

  /// Get a new dio proxy instance and put it in memory map
  static RedStoneDio newDio(
    String name,
    List<RedStoneInterceptor> interceptors,
    BaseOptions? options,
    RedStoneDioOption? rsDioOption,
  ) {
    RedStoneDio rsDio = RedStoneDio.newDio(
      name,
      interceptors: _processBuiltInInterceptor(
        interceptors,
        rsDioOption ?? RedStoneDioOption(),
      ),
      options: options,
    );
    _storageDioProxyInMemory(rsDio);
    return rsDio;
  }

  /// Get [_fixedRedStoneXDioName] default dio instance
  static Dio of() => _builtInRedStoneDio().dio;

  /// Get named [name] dio instance, maybe not
  /// exist of designated [name].
  static Dio? ofNamed(String name) => _dios[name]?.dio;

  /// Storage redstone dio proxy in memory
  ///
  /// Default will save in map or replace it if exist.
  static void _storageDioProxyInMemory(RedStoneDio rsDio) {
    _dios[rsDio.name] = rsDio;
  }

  /// Build and storage a default dio proxy instance
  static RedStoneDio _builtInRedStoneDio() {
    RedStoneDio? rsDio = _dios[_fixedRedStoneXDioName];
    if (rsDio != null) {
      return rsDio;
    }

    RedStoneDioOption rsDioOption = RedStoneDioOption(
      enableAutoLogInterceptor: true,
      enableRequestContextInterceptor: true,
      enableHttpLoadingEventPublish: true,
    );
    return newDio(
      _fixedRedStoneXDioName,
      [],
      RedStoneDio.defBaseOptions(),
      rsDioOption,
    );
  }

  /// process built-in interceptor
  static List<Interceptor> _processBuiltInInterceptor(
    List<RedStoneInterceptor> interceptors,
    RedStoneDioOption rsDioOption,
  ) {
    if (rsDioOption.enableHttpLoadingEventPublish ??
        GlobalConfig.of().globalHttpOptionConfigs.enableHttpLoadingEventPublish) {
      /// default publish http request event interceptor
      interceptors.add(BuiltInInterceptors.builtInLoadingPublisher);
    }

    if (rsDioOption.enableRequestContextInterceptor ??
        GlobalConfig.of().globalHttpOptionConfigs.enableRequestContextInterceptor) {
      /// default collect request information interceptor
      interceptors.add(BuiltInInterceptors.builtInRequestCtx);
      interceptors.add(BuiltInInterceptors.builtInResponseCtx);
      interceptors.add(BuiltInInterceptors.builtInErrorCtx);
    }

    if ((rsDioOption.enableAutoLogInterceptor ??
            GlobalConfig.of().globalHttpOptionConfigs.enableAutoLogInterceptor) &&
        !_hasLogInterceptor(interceptors)) {
      /// default log interceptor
      interceptors.add(BuiltInInterceptors.builtInLog);
    }

    interceptors.sort(
        (RedStoneInterceptor a, RedStoneInterceptor b) => a.order.compareTo(b.order));
    return interceptors.map((e) => e.interceptor).toList();
  }

  static bool _hasLogInterceptor(List<RedStoneInterceptor> interceptors) {
    return interceptors.isNotEmpty &&
        interceptors.any((e) => e.interceptor is LogInterceptor);
  }
}
