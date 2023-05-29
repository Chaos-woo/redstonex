import 'package:dio/dio.dart';
import 'package:example/net-manager/bili/bili_api.dart';
import 'package:example/net-manager/bili/bili_response_convert_interceptor.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

/// B站API客户端
class BiliNetClient extends GetxService {
  late final rHttpClient _httpClient;

  BiliNetClient() {
    rHttpOption option = (rHttpOptionBuilder()
          ..responseType = ResponseType.json
          ..receiveTimeOut = 10000)
        .build();

    _httpClient = rHttpClient(
      'https://api.bilibili.com',
      httpOption: option,
      interceptors: [
        BiliResponseConvertInterceptor(),
      ],
    );
  }

  /// 获取Bilibili热门视频列表
  Future<dynamic> requestBilibiliHotVideos(rPagingParams pagingParams, {bool Function(rApiException)? onError}) async {
    rHttpDataWrap httpDataWrap = rHttpDataWrap();
    httpDataWrap.param('ps', pagingParams.size);
    httpDataWrap.param('pn', pagingParams.currentIndex);
    // dynamic ret = await _httpClient.get<dynamic>(
    //   BiliApi.hotVideoPagingQuery,
    //   queryParameters: httpDataWrap.params,
    //   onError: onError,
    // );

    rRawData? rawRet = await _httpClient.get<rRawData>(
      BiliApi.hotVideoPagingQuery,
      queryParameters: httpDataWrap.params,
      onError: onError,
    );

    /// RawData新增方法测试
    // RawData rawData = RawData();
    // rawData.value = rawRet.objectAs<ApiResponse>(fromJsonConvertor: ApiResponse.fromJson);
    // print('${rawData.mapAs()}');
    // RawData rawBiliVideos = RawData();
    // rawBiliVideos.value = (rawData.mapAs()['data'] as Map<String, dynamic>)['list'];
    // print('${rawBiliVideos.listAs<BiliHotVideo>(fromJsonConvertor: BiliHotVideo.fromJson)}');

    return rawRet.value;
  }
}
