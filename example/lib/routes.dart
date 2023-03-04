import 'package:example/homepage/network_tools/bili_favorite_video/bili_favorite_video_binding.dart';
import 'package:example/homepage/network_tools/bili_favorite_video/bili_favorite_video_view.dart';
import 'package:example/homepage/network_tools/bili_hot_video/bili_hot_video_binding.dart';
import 'package:example/homepage/network_tools/bili_hot_video/bili_hot_video_view.dart';
import 'package:example/homepage/network_tools/bili_hot_video/components/bili_webview.dart';
import 'package:example/homepage/network_tools/history_weather_query/history_weather_query_binding.dart';
import 'package:example/homepage/network_tools/history_weather_query/history_weather_query_view.dart';
import 'package:example/homepage/simple_information/device_info/device_info_binding.dart';
import 'package:example/homepage/simple_information/device_info/device_info_view.dart';
import 'package:redstonex/routes/dispatcher.dart';
import 'package:redstonex/routes/router.dart';

class Routes {
  /// 业务路由初始化工具
  static void initGlobalRoutes() {
    RouterGroup deviceInfoGroup = XDispatcher.group(groupName: 'deviceInfo');
    deviceInfoGroup.newRoute(Router(RouteCompose.deviceRoute.baseInfo, () => DeviceInfoPage(), binding: DeviceInfoBinding()));

    RouterGroup weatherInfoGroup = XDispatcher.group(groupName: 'weatherInfo');
    weatherInfoGroup.newRoute(Router(RouteCompose.weatherRoute.homeWeather, () => HistoryWeatherQueryPage(), binding: HistoryWeatherQueryBinding()));

    RouterGroup bilibiliGroup = XDispatcher.group(groupName: 'bilibili');
    bilibiliGroup
        .newRoute(Router(RouteCompose.biliRoute.hotVideos, () => BiliHotVideoPage(), binding: BiliHotVideoBinding()))
        .newRoute(Router(RouteCompose.biliRoute.videoDetail, () => BiliWebView()))
        .newRoute(Router(RouteCompose.biliRoute.favoriteVideos, () => BiliFavoriteVideoPage(), binding: BiliFavoriteVideoBinding()));
  }
}

class RouteCompose {
  /// 路由业务分类
  static DeviceRoute deviceRoute = DeviceRoute();
  static WeatherRoute weatherRoute = WeatherRoute();
  static BiliRoute biliRoute = BiliRoute();
}

class DeviceRoute {
  String baseInfo = '/device/info/base';
}

class WeatherRoute {
  String homeWeather = '/weather/info/home';
}

class BiliRoute {
  String hotVideos = '/bili/hotVideo/home';
  String videoDetail = '/bili/hotVideo/detail';
  String favoriteVideos = '/bili/favorite/home';
}
