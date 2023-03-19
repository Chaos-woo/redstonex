// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_history_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityHistoryWeather _$CityHistoryWeatherFromJson(Map<String, dynamic> json) =>
    CityHistoryWeather()
      ..cityId = json['cityId'] as String
      ..cityName = json['cityName'] as String
      ..weatherDate = json['weatherDate'] as String
      ..weather = json['weather'] as String
      ..temp = json['temp'] as String
      ..windDirection = json['windDirection'] as String
      ..windComp = json['windComp'] as String
      ..weatherId = json['weatherId'] as String;

Map<String, dynamic> _$CityHistoryWeatherToJson(CityHistoryWeather instance) =>
    <String, dynamic>{
      'cityId': instance.cityId,
      'cityName': instance.cityName,
      'weatherDate': instance.weatherDate,
      'weather': instance.weather,
      'temp': instance.temp,
      'windDirection': instance.windDirection,
      'windComp': instance.windComp,
      'weatherId': instance.weatherId,
    };
