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

  final List<String> _favoriteVideoBids = [];
  final List<String> _lateSeeingVideoBids = [];

  bool isFavoriteVideo(String bVid) => _favoriteVideoBids.contains(bVid);
  bool isLateSeeingVideo(String bVid) => _lateSeeingVideoBids.contains(bVid);

  Future<void> favoriteBiliVideo(BiliHotVideo item) async {
    BiliFavoriteVideo record = BiliFavoriteVideo(
      bVid: item.bVid,
      tag: item.tagName,
      pic: item.pic,
      title: item.title,
      publishData: DateTime.fromMillisecondsSinceEpoch(item.pubDate * 1000),
      shortLink: item.shortLink,
      up: item.owner.name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _biliFavoriteVideoDao.insert0(record);
    _favoriteVideoBids.add(item.bVid);
  }

  Future<void> removeFavoriteBiliVideo(String bVid) async {
    BiliFavoriteVideo? item = await _biliFavoriteVideoDao.selectByBVid(bVid);
    if (null != item) {
      await _biliFavoriteVideoDao.delete0(item);
    }
    _lateSeeingVideoBids.remove(bVid);
  }

  Future<PagingBiliHotVideo> getBilibiliHotVideos(PagingParams pagingParams,
      {bool Function(ApiException)? onError}) async {
    dynamic ret = await _biliNetClient.requestBilibiliHotVideos(pagingParams, onError: onError);
    if (null != ret) {
      PagingBiliHotVideo pagingBiliHotVideo = PagingBiliHotVideo();
      Map<String, dynamic> pagingData = ret as Map<String, dynamic>;

      List<dynamic> dataList = pagingData['list'] as List<dynamic>;
      List<BiliHotVideo> biliHotVideos = dataList.map((json) => convertBiliHotVideo(json)).toList();
      pagingBiliHotVideo.list = biliHotVideos.map((b) {
        if (_favoriteVideoBids.contains(b.bVid)) {
          b.isFavorite = true;
        }
        return b;
      }).toList();
      pagingBiliHotVideo.noMore = pagingData['no_more'];
      return Future.value(pagingBiliHotVideo);
    }

    PagingBiliHotVideo empty = PagingBiliHotVideo();
    empty.list = [];
    empty.noMore = true;
    return Future.value(empty);
  }

  BiliHotVideo convertBiliHotVideo(dynamic dynamicJson) {
    Map<String, dynamic> json = dynamicJson as Map<String, dynamic>;
    return BiliHotVideo.fromJson(json);
  }

  void loadLocalBiliVideosBVids() async {
    List<BiliFavoriteVideo> favoriteBVids = await _biliFavoriteVideoDao.listBiliFavoriteVideos();
    _favoriteVideoBids.addAll(favoriteBVids.map((b) => b.bVid).toList());
  }

  void pagingFavoriteBiliVideos(int minId, int size) async {
    List<BiliFavoriteVideo> pagingBiliFavoriteVideo = await _biliFavoriteVideoDao.listBiliFavoriteVideos();
    InnerRefreshEvents<BiliFavoriteVideo> event = InnerRefreshEvents.success(data: pagingBiliFavoriteVideo);
    emitMulti(event);
  }
}
