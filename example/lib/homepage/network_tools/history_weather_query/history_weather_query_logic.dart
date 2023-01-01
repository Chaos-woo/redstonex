import 'package:example/services/models/city.dart';
import 'package:example/services/models/province.dart';
import 'package:example/services/models/province_with_city.dart';
import 'package:example/services/weather_service.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

import 'history_weather_query_state.dart';

class HistoryWeatherQueryLogic extends GetxController {
  final HistoryWeatherQueryState state = HistoryWeatherQueryState();
  final WeatherService weatherService = Depends.on();

  @override
  void onReady() async {
    await loadAllSupportProvinceCity();
    await loadLocalSelectedProvinceCity();
    update([weatherCityBuilderId]);
    super.onReady();
  }

  String get weatherCityBuilderId => 'w_city_bil';

  String get weatherDatetimeBuilderId => 'w_date_bil';

  String get weatherViewWindowBuilderId => 'w_window_bil';

  Future<void> loadAllSupportProvinceCity() async {
    List<ProvinceWithCity> pwcList = await weatherService.getSupportCities();
    state.supportProvinceCityState.provinceCity.addAll(pwcList);
  }

  Future<void> loadLocalSelectedProvinceCity() async {
    state.selectedProvinceCityState.province = await weatherService.getCacheSelectProvince();
    state.selectedProvinceCityState.city = await weatherService.getCacheSelectCity();
  }

  /// 地区历史天气数据查询
  Future<void> loadCityHistoryWeather(DateTime dateTime) async {
    String? selectedCityId = state.selectedProvinceCityState.city?.id;

    if (!selectedCityId.nullOrBlankObj) {
      /// API查询天气数据
      state.latestQueryWeatherState.weatherCompose =
      await weatherService.getCityHistoryWeatherCompose(cityId: selectedCityId!, dateTime: dateTime);
      state.userSelectCityOrDatetimeChange = false;
      update([weatherViewWindowBuilderId]);
    }
  }

  /// 聚合数据api免费版本有查询次数限制，因此选择日期后需要点击确认才能进行数据查询
  void cacheSelectHistoryWeatherDate(DateTime dateTime) {
    state.updateSelectedDateTime(dateTime);
    state.userSelectCityOrDatetimeChange = true;
    update([weatherDatetimeBuilderId, weatherViewWindowBuilderId]);
  }

  void selectLatestProvinceCity(List<int> selectPosition) {
    ProvinceWithCity pwc = state.supportProvinceCityState.provinceCity[selectPosition[0]];
    Province? province = pwc.getProvince();
    City? city = pwc.getCities()[selectPosition[1]];

    weatherService.cacheSelectLatestProvinceCity(province, city);
    state.selectedProvinceCityState.cacheUserSpecifyProvinceCity(province, city);
    state.userSelectCityOrDatetimeChange = true;
    update([weatherCityBuilderId, weatherViewWindowBuilderId]);
  }

  String getWeatherCodeIconPath(String weatherId, {bool daytime = true}) {
    if (weatherId == '00' && !daytime) {
      weatherId = '001';
    }

    return weatherService.getJvheWeatherIdImagePath(weatherId);
  }
}
