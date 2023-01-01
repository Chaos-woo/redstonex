import 'package:dio/dio.dart';
import 'package:example/net-manager/jvhe/jvhe_api.dart';
import 'package:example/net-manager/jvhe/jvhe_key_interceptor.dart';
import 'package:example/net-manager/jvhe/jvhe_response_convert_interceptor.dart';
import 'package:example/net-manager/jvhe/jvhe_response_error_interceptor.dart';
import 'package:get/get.dart';
import 'package:redstonex/net/utils/request_utils.dart';
import 'package:redstonex/redstonex.dart';

/// 聚合数据API客户端
class JvheNetClient extends GetxService {
  late final RequestClient _httpClient;

  JvheNetClient() {
    HttpOption option = HttpOptionBuilder().responseType(ResponseType.json).receiveTimeout(10000).build();

    _httpClient = RequestClient(
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
    List<dynamic>? ret = await _httpClient.get<List<dynamic>>(
      JvheApi.historyWeatherProvinces,
      onError: onError,
    );
    return ret;
  }

  /// 获取支持的城市列表
  Future<List<dynamic>?> requestHistoryWeatherCities(
    String provinceId, {
    bool Function(ApiException)? onError,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['province_id'] = provinceId;
    List<dynamic>? ret = await _httpClient.get<List<dynamic>>(
      JvheApi.historyWeatherCity,
      queryParameters: queryParameters,
      onError: onError,
    );
    return ret;
  }

  /// 获取地区历史天气
  Future<dynamic> requestHistoryWeatherByCity({
    required String cityId,
    required DateTime historyDate,
    bool Function(ApiException)? onError,
  }) async {
    RequestData rd = RequestData();
    rd.param('city_id', cityId);
    rd.param('weather_date', DatetimeUtils.yyyyMMddFormat(historyDate));
    return await _httpClient.get<dynamic>(
      JvheApi.historyWeather,
      queryParameters: rd.params,
      onError: onError,
    );
  }
}
