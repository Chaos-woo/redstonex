
import 'package:example/services/weather_service.dart';
import 'package:redstonex/redstonex.dart';

class ServicesManager {
  static void initServices() {
    Provides.provide(WeatherService());
  }
}