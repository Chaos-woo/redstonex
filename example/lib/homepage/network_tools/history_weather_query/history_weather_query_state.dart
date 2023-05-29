import 'package:example/homepage/network_tools/history_weather_query/models/city_history_weather_compose.dart';
import 'package:example/services/models/city.dart';
import 'package:example/services/models/province.dart';
import 'package:example/services/models/province_with_city.dart';
import 'package:redstonex/redstonex.dart';

class HistoryWeatherQueryState {
  late SupportProvinceCityState supportProvinceCityState;
  late SelectedProvinceCityState selectedProvinceCityState;
  late LatestQueryWeatherHistoryState latestQueryWeatherState;

  late DateTime selectDateTime;
  bool userSelectCityOrDatetimeChange = true;

  HistoryWeatherQueryState() {
    supportProvinceCityState = SupportProvinceCityState();
    selectedProvinceCityState = SelectedProvinceCityState();
    latestQueryWeatherState = LatestQueryWeatherHistoryState();

    selectDateTime = rDatetime().previousDay(DateTime.now());
  }

  void updateSelectedDateTime(DateTime dateTime) {
    selectDateTime = dateTime;
  }
}

class SupportProvinceCityState {
  List<ProvinceWithCity> provinceCity = [];

  Map<String, List<String>> convertLinkageableProvinceCity() {
    Map<String, List<String>> multiLinkageableData = {};
    for (ProvinceWithCity pwc in provinceCity) {
      multiLinkageableData[pwc.provinceName] = pwc.cities.map((e) => e.cityName).toList();
    }
    return multiLinkageableData;
  }
}

class SelectedProvinceCityState {
  Province? province;
  City? city;

  void cacheUserSpecifyProvinceCity(Province province, City city) {
    this.province = province;
    this.city = city;
  }
}

class LatestQueryWeatherHistoryState {
  /// 白天/夜晚天气数据
  CityHistoryWeatherCompose weatherCompose = CityHistoryWeatherCompose.placeholder();
}
