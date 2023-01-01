import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/homepage/network_tools/history_weather_query/models/city_history_weather.dart';

CityHistoryWeather $CityHistoryWeatherFromJson(Map<String, dynamic> json) {
	final CityHistoryWeather cityHistoryWeather = CityHistoryWeather();
	final String? cityId = jsonConvert.convert<String>(json['cityId']);
	if (cityId != null) {
		cityHistoryWeather.cityId = cityId;
	}
	final String? cityName = jsonConvert.convert<String>(json['cityName']);
	if (cityName != null) {
		cityHistoryWeather.cityName = cityName;
	}
	final String? weatherDate = jsonConvert.convert<String>(json['weatherDate']);
	if (weatherDate != null) {
		cityHistoryWeather.weatherDate = weatherDate;
	}
	final String? weather = jsonConvert.convert<String>(json['weather']);
	if (weather != null) {
		cityHistoryWeather.weather = weather;
	}
	final String? temp = jsonConvert.convert<String>(json['temp']);
	if (temp != null) {
		cityHistoryWeather.temp = temp;
	}
	final String? windDirection = jsonConvert.convert<String>(json['windDirection']);
	if (windDirection != null) {
		cityHistoryWeather.windDirection = windDirection;
	}
	final String? windComp = jsonConvert.convert<String>(json['windComp']);
	if (windComp != null) {
		cityHistoryWeather.windComp = windComp;
	}
	final String? weatherId = jsonConvert.convert<String>(json['weatherId']);
	if (weatherId != null) {
		cityHistoryWeather.weatherId = weatherId;
	}
	return cityHistoryWeather;
}

Map<String, dynamic> $CityHistoryWeatherToJson(CityHistoryWeather entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cityId'] = entity.cityId;
	data['cityName'] = entity.cityName;
	data['weatherDate'] = entity.weatherDate;
	data['weather'] = entity.weather;
	data['temp'] = entity.temp;
	data['windDirection'] = entity.windDirection;
	data['windComp'] = entity.windComp;
	data['weatherId'] = entity.weatherId;
	return data;
}