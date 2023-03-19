import 'package:dio/dio.dart';
import 'package:example/net-manager/jvhe/jvhe_api.dart';
import 'package:example/net-manager/jvhe/jvhe_key_interceptor.dart';
import 'package:example/net-manager/jvhe/jvhe_response_convert_interceptor.dart';
import 'package:example/net-manager/jvhe/jvhe_response_error_interceptor.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

/// 聚合数据API客户端
class JvheNetClient extends GetxService {
  late final HttpClient _httpClient;

  JvheNetClient() {
    HttpOption option = HttpOptionBuilder().responseType(ResponseType.json).receiveTimeout(10000).build();

    _httpClient = HttpClient(
      'http://v.juhe.cn',
      httpOption: option,
      interceptors: [
        JvheKeyInterceptor(),
        JvheResponseErrorInterceptor(),
        JvheResponseConvertInterceptor(),
      ],
    );
  }

  /// 获取支持的省列表
  Future<List<dynamic>?> requestHistoryWeatherProvinces({bool Function(ApiException)? onError}) async {
    RawData ret = await _httpClient.get<RawData>(
      JvheApi.historyWeatherProvinces,
      onError: onError,
    );
    return ret.value;
  }

  /// 获取支持的城市列表
  Future<List<dynamic>?> requestHistoryWeatherCities(
    String provinceId, {
    bool Function(ApiException)? onError,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['province_id'] = provinceId;
    RawData ret = await _httpClient.get<RawData>(
      JvheApi.historyWeatherCity,
      queryParameters: queryParameters,
      onError: onError,
    );
    return ret.value;
  }

  /// 获取地区历史天气
  Future<dynamic> requestHistoryWeatherByCity({
    required String cityId,
    required DateTime historyDate,
    bool Function(ApiException)? onError,
  }) async {
    HttpDataWrap httpDataWrap = HttpDataWrap();
    httpDataWrap.param('city_id', cityId);
    httpDataWrap.param('weather_date', XDatetime().yyyyMMddFormat(historyDate));
    return (await _httpClient.get<RawData>(
      JvheApi.historyWeather,
      queryParameters: httpDataWrap.params,
      onError: onError,
    )).value;
  }
}
