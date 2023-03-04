import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:example/db-manager/example_base_floor_database.dart';
import 'package:example/db-manager/example_dao.dart';
import 'package:example/net-manager/bili/bili_net_client.dart';
import 'package:example/services/models/bili_hot_video.dart';
import 'package:example/services/models/paging_bili_hot_video.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';

class BiliService extends GetxService with HasEventEmitter {
  final BiliNetClient _biliNetClient = XDepends().on();
  final BiliFavoriteVideoDao _biliFavoriteVideoDao = MyExampleDb().database.biliFavoriteVideoDao;

  Future<PagingBiliHotVideo> getBilibiliHotVideos(PagingParams pagingParams,
      {bool Function(ApiException)? onError}) async {
    dynamic ret = await _biliNetClient.requestBilibiliHotVideos(pagingParams, onError: onError);
    if (null != ret) {
      PagingBiliHotVideo pagingBiliHotVideo = PagingBiliHotVideo();
      Map<String, dynamic> pagingData = ret as Map<String, dynamic>;

      List<dynamic> dataList = pagingData['list'] as List<dynamic>;
      List<BiliHotVideo> biliHotVideos = dataList.map((json) => convertBilibiliHotVideo(json)).toList();
      pagingBiliHotVideo.list = biliHotVideos;
      pagingBiliHotVideo.noMore = pagingData['no_more'];
      return Future.value(pagingBiliHotVideo);
    }

    PagingBiliHotVideo empty = PagingBiliHotVideo();
    empty.list = [];
    empty.noMore = true;
    return Future.value(empty);
  }

  BiliHotVideo convertBilibiliHotVideo(dynamic dynamicJson) {
    Map<String, dynamic> json = dynamicJson as Map<String, dynamic>;
    return BiliHotVideo.fromJson(json);
  }

  void pagingFavorite(int minId, int size) async {
    List<BiliFavoriteVideo> pagingBiliFavoriteVideo = await _biliFavoriteVideoDao.listBiliFavoriteVideos();
    InnerRefreshEvents<BiliFavoriteVideo> event = InnerRefreshEvents.success(data: pagingBiliFavoriteVideo);
    emitMulti(event);
  }
}
