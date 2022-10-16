import 'package:dio/dio.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/commons/standards/of_syntax.dart';
import 'package:redstonex/network-core/definitions/http/redstone_interceptor.dart';
import 'package:redstonex/network-core/definitions/interceptors/builtin_interceptors.dart';
import 'package:redstonex/network-core/definitions/proxy/redstone_dio.dart';
import 'package:redstonex/network-core/definitions/proxy/redstone_dio_option.dart';

/// A Dio configuration creator.
///
class Dios with OfSyntax {
  /// fixed redstone dio name
  static const String _fixedRedStoneXDioName = '_fixedRedStoneXDio';

  /// named dio instance map
  static final Map<String, RedstoneDio> _dios = {};

  /// Get a new dio proxy instance and put it in memory map
  static RedstoneDio newDio(
    String name,
    List<RedstoneInterceptor> interceptors,
    BaseOptions? options,
    RedstoneDioOption? rsDioOption,
  ) {
    RedstoneDio rsDio = RedstoneDio.newDio(
      name,
      interceptors: _processBuiltinInterceptor(
        interceptors,
        rsDioOption ?? RedstoneDioOption(),
      ),
      options: options,
    );
    _storageDioProxyInMemory(rsDio);
    return rsDio;
  }

  /// Get [_fixedRedStoneXDioName] default dio instance
  static Dio of() => _builtInRedstoneDio().dio;

  /// Get named [name] dio instance, maybe not
  /// exist of designated [name].
  static Dio? ofNamed(String name) => _dios[name]?.dio;

  /// Storage redstone dio proxy in memory
  ///
  /// Default will save in map or replace it if exist.
  static void _storageDioProxyInMemory(RedstoneDio rsDio) {
    _dios[rsDio.name] = rsDio;
  }

  /// Build and storage a default dio proxy instance
  static RedstoneDio _builtInRedstoneDio() {
    RedstoneDio? rsDio = _dios[_fixedRedStoneXDioName];
    if (rsDio != null) {
      return rsDio;
    }

    RedstoneDioOption rsDioOption = RedstoneDioOption(
      enableAutoLogInterceptor: true,
      enableRequestContextInterceptor: true,
      enableHttpLoadingEventPublish: true,
    );
    return newDio(
      _fixedRedStoneXDioName,
      [],
      RedstoneDio.defBaseOptions(),
      rsDioOption,
    );
  }

  /// process built-in interceptor
  static List<Interceptor> _processBuiltinInterceptor(
    List<RedstoneInterceptor> interceptors,
    RedstoneDioOption rsDioOption,
  ) {
    if (rsDioOption.enableHttpLoadingEventPublish ??
        GlobalConfig.of().globalHttpOptionConfigs.enableHttpLoadingEventPublish) {
      /// default publish http request event interceptor
      interceptors.add(BuiltinInterceptors.builtinLoadingPublisher);
    }

    if (rsDioOption.enableRequestContextInterceptor ??
        GlobalConfig.of().globalHttpOptionConfigs.enableRequestContextInterceptor) {
      /// default collect request information interceptor
      interceptors.add(BuiltinInterceptors.builtinRequestCtx);
      interceptors.add(BuiltinInterceptors.builtinResponseCtx);
      interceptors.add(BuiltinInterceptors.builtinErrorCtx);
    }

    if ((rsDioOption.enableAutoLogInterceptor ??
            GlobalConfig.of().globalHttpOptionConfigs.enableAutoLogInterceptor) &&
        !_hasLogInterceptor(interceptors)) {
      /// default log interceptor
      interceptors.add(BuiltinInterceptors.builtinLog);
    }

    interceptors.sort(
        (RedstoneInterceptor a, RedstoneInterceptor b) => a.order.compareTo(b.order));
    return interceptors.map((e) => e.interceptor).toList();
  }

  static bool _hasLogInterceptor(List<RedstoneInterceptor> interceptors) {
    return interceptors.isNotEmpty &&
        interceptors.any((e) => e.interceptor is LogInterceptor);
  }
}
