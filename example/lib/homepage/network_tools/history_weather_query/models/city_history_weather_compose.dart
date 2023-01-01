
import 'package:example/homepage/network_tools/history_weather_query/models/city_history_weather.dart';

class CityHistoryWeatherCompose {
  late CityHistoryWeather dayWeather;
  late CityHistoryWeather nightWeather;

  CityHistoryWeatherCompose(this.dayWeather, this.nightWeather);

  CityHistoryWeatherCompose.placeholder() {
    dayWeather = CityHistoryWeather.placeholder();
    nightWeather = CityHistoryWeather.placeholder();
  }
}