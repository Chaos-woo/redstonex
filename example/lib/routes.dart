import 'package:example/homepage/lottie_index.dart';
import 'package:example/homepage/network_tools/bili_favorite_video/bili_favorite_video_binding.dart';
import 'package:example/homepage/network_tools/bili_favorite_video/bili_favorite_video_view.dart';
import 'package:example/homepage/network_tools/bili_hot_video/bili_hot_video_binding.dart';
import 'package:example/homepage/network_tools/bili_hot_video/bili_hot_video_view.dart';
import 'package:example/homepage/network_tools/bili_hot_video/components/bili_webview.dart';
import 'package:example/homepage/network_tools/history_weather_query/history_weather_query_binding.dart';
import 'package:example/homepage/network_tools/history_weather_query/history_weather_query_view.dart';
import 'package:example/homepage/simple_information/device_info/device_info_binding.dart';
import 'package:example/homepage/simple_information/device_info/device_info_view.dart';
import 'package:example/homepage/text_index.dart';
import 'package:redstonex/routes/dispatcher.dart';
import 'package:redstonex/routes/router.dart';

class Routes {
  /// 业务路由初始化工具
  static void initGlobalRoutes() {
    rRouteGroup deviceInfoGroup = rDispatcher.group(groupName: 'deviceInfo');
    deviceInfoGroup.newRoute(
        rRoute(RouteCompose.deviceRoute.baseInfo, () => DeviceInfoPage(), binding: DeviceInfoBinding()));

    rRouteGroup weatherInfoGroup = rDispatcher.group(groupName: 'weatherInfo');
    weatherInfoGroup.newRoute(rRoute(RouteCompose.weatherRoute.homeWeather, () => HistoryWeatherQueryPage(),
        binding: HistoryWeatherQueryBinding()));

    rRouteGroup bilibiliGroup = rDispatcher.group(groupName: 'bilibili');
    bilibiliGroup
        .newRoute(rRoute(RouteCompose.biliRoute.hotVideos, () => BiliHotVideoPage(),
            binding: BiliHotVideoBinding()))
        .newRoute(rRoute(RouteCompose.biliRoute.videoDetail, () => BiliWebView()))
        .newRoute(rRoute(RouteCompose.biliRoute.favoriteVideos, () => BiliFavoriteVideoPage(),
            binding: BiliFavoriteVideoBinding()));

    rRouteGroup lottieGroup = rDispatcher.group(groupName: 'lottie');
    lottieGroup.newRoute(
        rRoute(RouteCompose.lottieRoute.index, () => LottieIndex(),));

    rRouteGroup textGroup = rDispatcher.group(groupName: 'text');
    textGroup.newRoute(
        rRoute(RouteCompose.textRoute.index, () => TextIndex(),));
  }
}

class RouteCompose {
  /// 路由业务分类
  static DeviceRoute deviceRoute = DeviceRoute();
  static WeatherRoute weatherRoute = WeatherRoute();
  static BiliRoute biliRoute = BiliRoute();
  static LottieRoute lottieRoute = LottieRoute();
  static TextRoute textRoute = TextRoute();
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

class LottieRoute {
  String index = '/lottie/home';
}

class TextRoute {
  String index = '/text/home';
}

