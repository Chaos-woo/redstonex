import 'package:example/homepage/network_tools/history_weather_query/history_weather_query_binding.dart';
import 'package:example/homepage/network_tools/history_weather_query/history_weather_query_view.dart';
import 'package:example/homepage/simple_information/device_info/device_info_binding.dart';
import 'package:example/homepage/simple_information/device_info/device_info_view.dart';
import 'package:redstonex/routes/dispatcher.dart';
import 'package:redstonex/routes/router.dart';

class Routes {
  /// 业务路由初始化工具
  static void initGlobalRoutes() {
    RouterGroup deviceInfoGroup = Dispatcher.group(groupName: 'deviceInfo');
    deviceInfoGroup.newRoute(Router(RouteCompose.deviceRoute.baseInfo, () => DeviceInfoPage(), binding: DeviceInfoBinding()));

    RouterGroup weatherInfoGroup = Dispatcher.group(groupName: 'weatherInfo');
    weatherInfoGroup.newRoute(Router(RouteCompose.weatherRoute.homeWeather, () => HistoryWeatherQueryPage(), binding: HistoryWeatherQueryBinding()));
  }
}

class RouteCompose {
  /// 路由业务分类
  static DeviceRoute deviceRoute = DeviceRoute();
  static WeatherRoute weatherRoute = WeatherRoute();
}

class DeviceRoute {
  String baseInfo = '/device/info/base';
}

class WeatherRoute {
  String homeWeather = '/weather/info/home';
}