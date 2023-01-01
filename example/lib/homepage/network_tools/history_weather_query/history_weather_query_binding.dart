import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

import 'history_weather_query_logic.dart';

class HistoryWeatherQueryBinding extends Bindings {
  @override
  void dependencies() {
    Provides.lazyProvide(HistoryWeatherQueryLogic());
  }
}
