import 'package:json_annotation/json_annotation.dart';

part 'city_history_weather.g.dart';

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

  factory CityHistoryWeather.fromJson(Map<String, dynamic> json) => _$CityHistoryWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CityHistoryWeatherToJson(this);

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
