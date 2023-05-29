import 'package:example/homepage/network_tools/history_weather_query/models/city_history_weather.dart';
import 'package:example/homepage/network_tools/history_weather_query/models/city_history_weather_compose.dart';
import 'package:example/providers/jvhe_api_provider.dart';
import 'package:example/services/models/city.dart';
import 'package:example/services/models/province.dart';
import 'package:example/services/models/province_with_city.dart';
import 'package:example/services/models/with_city.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

/// 天气服务
/// 业务服务模块向上提供统一逻辑方法
class WeatherService extends GetxService {
  final JvheApiProvider _jvheApiProvider = rDepends().on();

  /// [onError] 用于向下传递错误处理：
  /// 1. view向controller传递的页面处理
  /// 2. controller向service传递的数据处理和页面刷新处理
  /// 3. service向数据提供者(例如：[JvheApiProvider])的数据处理
  /// 4*. 根据业务需要判断哪些需要处理异常，哪些不需要处理异常，也可向下传递时再做额外的包装处理
  /// 5. 最好异常在interceptor或下层判断并向上抛出异常，这样上层服务不用处理可空对象，而仅处理对象中的可空属性

  Future<void> printLocalCache() async {
    String supportProvinceCityKeyPrefix = 'kJvheCities';
    List<Province> pList = await getSupportProvinces();
    for (Province p in pList) {
      List<City>? cityCache = rShared().getObjList(supportProvinceCityKeyPrefix + p.id, (v) {
        Map<String, dynamic> cData = v as Map<String, dynamic>;
        City city = City();
        city.id = cData['id'];
        city.name = cData['name'];
        city.provinceId = cData['provinceId'];
        return city;
      });
      rLog().debug('localCache province(${p.name}, ${p.id}), cities: $cityCache');
    }
  }

  Future<List<Province>> getSupportProvinces() async {
    String supportProvinceKey = 'kJvheProvinces';
    List<Province>? pCache = rShared().getObjList(supportProvinceKey, (v) {
      Map<String, dynamic> pData = v as Map<String, dynamic>;
      Province p = Province();
      p.id = pData['id'];
      p.name = pData['name'];
      return p;
    });

    /// 缓存不存在时获取新数据
    if (null == pCache) {
      rLog().debug('not hit province cache');
      pCache = await _jvheApiProvider.getHistoryWeatherSupportProvinces();
      rShared().putObjectList(supportProvinceKey, pCache);
    }

    /// 演示仅使用了1个省份
    return pCache.sublist(0, 1);
  }

  Future<List<ProvinceWithCity>> getSupportCities() async {
    List<Province> provinces = await getSupportProvinces();
    Map<String, Province> provinceMap = {};
    List<ProvinceWithCity> provinceCities = [];
    List<String> notCacheCitiesProvinceIds = [];
    String supportProvinceCityKeyPrefix = 'kJvheCities';

    for (Province p in provinces) {
      List<City>? cityCache = rShared().getObjList(supportProvinceCityKeyPrefix + p.id, (v) {
        Map<String, dynamic> cData = v as Map<String, dynamic>;
        City city = City();
        city.id = cData['id'];
        city.name = cData['name'];
        city.provinceId = cData['provinceId'];
        return city;
      });

      if (null == cityCache) {
        notCacheCitiesProvinceIds.add(p.id);
        provinceMap[p.id] = p;
      } else {
        provinceCities.add(_pakProvinceCity(p, cityCache));
      }
    }

    /// 缓存不存在时获取新数据
    if (notCacheCitiesProvinceIds.isNotEmpty) {
      /// 使用聚合数据批量获取省份对应的城市地区，异步大量请求导致请求异常，无法获取指定城市数据
      /// 因此，演示仅使用1个省份
      List<City> cities = await _jvheApiProvider.getHistoryWeatherMultiProvinceSupportCities(notCacheCitiesProvinceIds);
      for (String pId in notCacheCitiesProvinceIds) {
        List<City> currentProvinceCities = cities.where((element) => pId == element.provinceId).toList();
        rShared().putObjectList(supportProvinceCityKeyPrefix + pId, currentProvinceCities);
        provinceCities.add(_pakProvinceCity(provinceMap[pId]!, currentProvinceCities));
      }
    }

    provinceCities.sort((p1, p2) => p1.provinceId.compareTo(p2.provinceId));

    return provinceCities;
  }

  ProvinceWithCity _pakProvinceCity(Province province, List<City> cities) {
    ProvinceWithCity pwc = ProvinceWithCity();
    pwc.provinceId = province.id;
    pwc.provinceName = province.name;
    pwc.cities = cities.map((e) {
      WithCity pc = WithCity();
      pc.cityId = e.id;
      pc.cityName = e.name;
      return pc;
    }).toList();
    return pwc;
  }

  static String kSelectedProvince = 'kSelectProvince';
  static String kSelectedCity = 'kSelectCity';

  /// 缓存当前选择城市
  void cacheSelectLatestProvinceCity(Province province, City city) {
    rShared().putObj(kSelectedProvince, province);
    rShared().putObj(kSelectedCity, city);
  }

  /// 获取缓存中选中的省份
  Future<Province?> getCacheSelectProvince() async {
    return rShared().getObj(kSelectedProvince, (v) {
      Map<String, dynamic> pData = v as Map<String, dynamic>;
      Province p = Province();
      p.id = pData['id'];
      p.name = pData['name'];
      return p;
    });
  }

  /// 获取缓存中选中的城市或地区
  Future<City?> getCacheSelectCity() async {
    return rShared().getObj(kSelectedCity, (v) {
      Map<String, dynamic> cData = v as Map<String, dynamic>;
      City c = City();
      c.id = cData['id'];
      c.name = cData['name'];
      c.provinceId = cData['provinceId'];
      return c;
    });
  }

  Future<CityHistoryWeatherCompose> getCityHistoryWeatherCompose({required String cityId, required DateTime dateTime}) async {
    CityHistoryWeather dayWeather = CityHistoryWeather.placeholder();
    CityHistoryWeather nightWeather = CityHistoryWeather.placeholder();
    dayWeather.weatherDate = rDatetime().yyyyMMddFormat(dateTime);
    nightWeather.weatherDate = rDatetime().yyyyMMddFormat(dateTime);
    List<CityHistoryWeather> cityHistoryWeathers = await _jvheApiProvider.getSingleCityWeather(cityId: cityId, dateTime: dateTime);
    if (cityHistoryWeathers.isNotEmpty) {
      dayWeather = cityHistoryWeathers[0];
      nightWeather = cityHistoryWeathers[1];
    }
    return CityHistoryWeatherCompose(dayWeather, nightWeather);
  }

  static Map<String, String> apiWeatherTypeImages = {
    '00': 'assets/images/weather/qingtian.png',
    '001': 'assets/images/weather/yewan.png',
    '01': 'assets/images/weather/duoyun.png',
    '02': 'assets/images/weather/yintian.png',
    '03': 'assets/images/weather/zhenyu.png',
    '04': 'assets/images/weather/zhenyu.png',
    '05': 'assets/images/weather/bingbaoyu.png',
    '06': 'assets/images/weather/yuxue.png',
    '07': 'assets/images/weather/xiayu.png',
    '08': 'assets/images/weather/xiaoyu.png',
    '09': 'assets/images/weather/dayu.png',
    '10': 'assets/images/weather/dayu.png',
    '11': 'assets/images/weather/dayu.png',
    '12': 'assets/images/weather/dayu.png',
    '13': 'assets/images/weather/xiaoxue.png',
    '14': 'assets/images/weather/xiaoxue.png',
    '15': 'assets/images/weather/xiaoxue.png',
    '16': 'assets/images/weather/daxue.png',
    '17': 'assets/images/weather/daxue.png',
    '18': 'assets/images/weather/dawu.png',
    '19': 'assets/images/weather/bingbaoyu.png',
    '20': 'assets/images/weather/shachen.png',
    '21': 'assets/images/weather/xiayu.png',
    '22': 'assets/images/weather/xiayu.png',
    '23': 'assets/images/weather/dayu.png',
    '24': 'assets/images/weather/dayu.png',
    '25': 'assets/images/weather/dayu.png',
    '26': 'assets/images/weather/xiaoxue.png',
    '27': 'assets/images/weather/xiaoxue.png',
    '28': 'assets/images/weather/daxue.png',
    '29': 'assets/images/weather/chentu.png',
    '30': 'assets/images/weather/shachen.png',
    '31': 'assets/images/weather/fengbao.png',
    '53': 'assets/images/weather/mai.png',
    '-1': 'assets/images/weather/zhongyu.png',
  };

  String getJvheWeatherIdImagePath(String weatherId) {
    return apiWeatherTypeImages.containsKey(weatherId) ? apiWeatherTypeImages[weatherId]! : apiWeatherTypeImages['-1']!;
  }
}
