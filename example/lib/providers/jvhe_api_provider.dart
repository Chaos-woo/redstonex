import 'package:example/homepage/network_tools/history_weather_query/models/city_history_weather.dart';
import 'package:example/net-manager/jvhe/jvhe_net_client.dart';
import 'package:example/services/models/city.dart';
import 'package:example/services/models/province.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

/// 聚合数据提供网站
/// 数据提供模块向上提供数据，数据依赖可以为缓存、本地数据库、网络数据等
class JvheApiProvider extends GetxService {
  final JvheNetClient _jvheNetClient = XDepends().on();

  /// 历史天气支持的省份
  Future<List<Province>> getHistoryWeatherSupportProvinces({bool Function(ApiException)? onError}) async {
    final List<Province> supportProvinces = [];
    await SyncRequester.load(
      () async {
        List<dynamic>? provinces = await _jvheNetClient.requestHistoryWeatherProvinces(onError: onError);
        if (null != provinces) {
          List<Province> convertRet = provinces.map((e) {
            Map<String, dynamic> pData = e;
            Province p = Province();
            p.id = pData['id'];
            p.name = pData['province'];
            return p;
          }).toList();
          supportProvinces.addAll(convertRet);
        }
      },
      onError: onError,
      loadingText: '加载中...',
    );
    return supportProvinces;
  }

  /// 历史天气支持的城市地区
  Future<List<City>> getHistoryWeatherSingleProvinceSupportCities(String provinceId, {bool Function(ApiException)? onError}) async {
    final List<City> supportProvinces = [];
    await SyncRequester.load(
      () async {
        List<City> cities = await getSingleProvinceRelatedCities(provinceId);
        supportProvinces.addAll(cities);
      },
      onError: onError,
      loadingText: '加载中...',
    );
    return supportProvinces;
  }

  /// 历史天气支持的城市地区
  Future<List<City>> getHistoryWeatherMultiProvinceSupportCities(List<String> provinceIds, {bool Function(ApiException)? onError}) async {
    final List<City> supportCities = [];
    DateTime start = DateTime.now();
    await ParallelRequester.load(
      provinceIds
          .map((e) => ParallelRequest(
                getSingleProvinceRelatedCities(e),
                onValue: (dynamic value) {
                  supportCities.addAll(value);
                },
              ))
          .toList(),
      onError: onError,
      loadingText: '加载中...',
    );
    XLog().debug('request all provinceId cost: ${DateTime.now().millisecondsSinceEpoch - start.millisecondsSinceEpoch}');
    return supportCities;
  }

  /// 历史天气支持省份关联的城市地区
  Future<List<City>> getSingleProvinceRelatedCities(String provinceId) async {
    final List<City> supportCities = [];
    DateTime start = DateTime.now();
    List<dynamic>? cities = await _jvheNetClient.requestHistoryWeatherCities(provinceId);
    XLog().debug('request $provinceId cost: ${DateTime.now().millisecondsSinceEpoch - start.millisecondsSinceEpoch}');
    if (null != cities) {
      List<City> convertRet = cities.map((e) {
        Map<String, dynamic> cData = e;
        City city = City();
        city.id = cData['id'];
        city.provinceId = cData['province_id'];
        city.name = cData['city_name'];
        return city;
      }).toList();
      supportCities.addAll(convertRet);
    }
    return supportCities;
  }

  /// 城市地区历史白天/夜晚天气数据
  Future<List<CityHistoryWeather>> getSingleCityWeather({required String cityId, required DateTime dateTime}) async {
    DateTime start = DateTime.now();
    dynamic cityWeather = await _jvheNetClient.requestHistoryWeatherByCity(
      cityId: cityId,
      historyDate: dateTime,
    );
    XLog().debug('request $cityId cost: ${DateTime.now().millisecondsSinceEpoch - start.millisecondsSinceEpoch}');
    if (null != cityWeather) {
      Map<String, dynamic> wData = cityWeather;
      CityHistoryWeather dayWeather = CityHistoryWeather();
      dayWeather.cityId = wData['city_id'];
      dayWeather.cityName = wData['city_name'];
      dayWeather.weatherDate = wData['weather_date'];
      dayWeather.weather = wData['day_weather'];
      dayWeather.temp = wData['day_temp'];
      dayWeather.windDirection = wData['day_wind'];
      dayWeather.windComp = wData['day_wind_comp'];
      dayWeather.weatherId = wData['day_weather_id'];

      CityHistoryWeather nightWeather = CityHistoryWeather();
      nightWeather.cityId = wData['city_id'];
      nightWeather.cityName = wData['city_name'];
      nightWeather.weatherDate = wData['weather_date'];
      nightWeather.weather = wData['night_weather'];
      nightWeather.temp = wData['night_temp'];
      nightWeather.windDirection = wData['night_wind'];
      nightWeather.windComp = wData['night_wind_comp'];
      nightWeather.weatherId = wData['night_weather_id'];

      return [dayWeather, nightWeather];
    }
    return [];
  }
}
