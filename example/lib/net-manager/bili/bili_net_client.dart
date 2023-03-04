import 'package:dio/dio.dart';
import 'package:example/net-manager/bili/bili_api.dart';
import 'package:example/net-manager/bili/bili_response_convert_interceptor.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

/// B站API客户端
class BiliNetClient extends GetxService {
  late final HttpClient _httpClient;

  BiliNetClient() {
    HttpOption option = HttpOptionBuilder().responseType(ResponseType.json).receiveTimeout(10000).build();

    _httpClient = HttpClient(
      'https://api.bilibili.com',
      httpOption: option,
      interceptors: [
        BiliResponseConvertInterceptor(),
      ],
    );
  }

  /// 获取Bilibili热门视频列表
  Future<dynamic> requestBilibiliHotVideos(PagingParams pagingParams, {bool Function(ApiException)? onError}) async {
    HttpDataWrap httpDataWrap = HttpDataWrap();
    httpDataWrap.param('ps', pagingParams.size);
    httpDataWrap.param('pn', pagingParams.currentIndex);
    dynamic ret = await _httpClient.get<dynamic>(
      BiliApi.hotVideoPagingQuery,
      queryParameters: httpDataWrap.params,
      onError: onError,
    );
    return ret;
  }
}
