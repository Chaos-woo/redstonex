
import 'package:example/services/bili_service.dart';
import 'package:example/services/weather_service.dart';
import 'package:redstonex/redstonex.dart';

class ServicesManager {
  static void initServices() {
    XProvides().provide(WeatherService());
    XProvides().provide(BiliService());
  }
}