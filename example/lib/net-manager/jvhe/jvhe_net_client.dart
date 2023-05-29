import 'package:dio/dio.dart';
import 'package:example/net-manager/jvhe/jvhe_api.dart';
import 'package:example/net-manager/jvhe/jvhe_key_interceptor.dart';
import 'package:example/net-manager/jvhe/jvhe_response_convert_interceptor.dart';
import 'package:example/net-manager/jvhe/jvhe_response_error_interceptor.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

/// 聚合数据API客户端
class JvheNetClient extends GetxService {
  late final rHttpClient _httpClient;

  JvheNetClient() {
    rHttpOption option = (rHttpOptionBuilder()
      ..responseType = ResponseType.json
      ..receiveTimeOut = 10000)
        .build();

    _httpClient = rHttpClient(
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
  Future<List<dynamic>?> requestHistoryWeatherProvinces({bool Function(rApiException)? onError}) async {
    rRawData ret = await _httpClient.get<rRawData>(
      JvheApi.historyWeatherProvinces,
      onError: onError,
    );
    return ret.value;
  }

  /// 获取支持的城市列表
  Future<List<dynamic>?> requestHistoryWeatherCities(
    String provinceId, {
    bool Function(rApiException)? onError,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['province_id'] = provinceId;
    rRawData ret = await _httpClient.get<rRawData>(
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
    bool Function(rApiException)? onError,
  }) async {
    rHttpDataWrap httpDataWrap = rHttpDataWrap();
    httpDataWrap.param('city_id', cityId);
    httpDataWrap.param('weather_date', rDatetime().yyyyMMddFormat(historyDate));
    return (await _httpClient.get<rRawData>(
      JvheApi.historyWeather,
      queryParameters: httpDataWrap.params,
      onError: onError,
    )).value;
  }
}
