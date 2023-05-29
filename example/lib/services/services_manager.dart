
import 'package:example/services/bili_service.dart';
import 'package:example/services/weather_service.dart';
import 'package:redstonex/redstonex.dart';

class ServicesManager {
  static void initServices() {
    rProvides().provide(WeatherService());
    rProvides().provide(BiliService());
  }
}