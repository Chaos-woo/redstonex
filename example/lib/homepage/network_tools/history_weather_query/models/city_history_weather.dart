import 'dart:convert';

import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/city_history_weather.g.dart';

@JsonSerializable()
class CityHistoryWeather {
  late String cityId;
  late String cityName;
  late String weatherDate;
  late String weather;
  late String temp;
  late String windDirection;
  late String windComp;
  late String weatherId;

  CityHistoryWeather();

  factory CityHistoryWeather.fromJson(Map<String, dynamic> json) => $CityHistoryWeatherFromJson(json);

  Map<String, dynamic> toJson() => $CityHistoryWeatherToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  CityHistoryWeather.placeholder() {
    cityId = '-1';
    cityName = '--';
    weatherDate = '';
    weather = '--';
    temp = '--℃';
    windDirection = '--';
    windComp = '--';
    weatherId = '-1';
  }
}
