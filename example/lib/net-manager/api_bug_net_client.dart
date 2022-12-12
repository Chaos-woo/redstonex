import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

class ApiBugNetClient extends GetxService {
  late final RequestClient _requestClient;

  ApiBugNetClient() {
    HttpOption option = HttpOptionBuilder().responseType(ResponseType.json).receiveTimeout(10000).build();
    _requestClient = RequestClient(
      'https://apibug.cn',
      httpOption: option,
    );
  }

  /// 随机返回网易云音乐随机热评
  Future<void> loadRandomNeteaseHotComment() async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['format'] = 'json';
    queryParameters['apiKey'] = '';
    _requestClient.get('/api/163rp/', queryParameters: queryParameters, showLoading: true);
  }
}
