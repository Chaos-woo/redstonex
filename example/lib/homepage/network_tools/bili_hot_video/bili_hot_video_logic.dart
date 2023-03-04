import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:example/db-manager/example_base_floor_database.dart';
import 'package:example/db-manager/example_dao.dart';
import 'package:example/services/bili_service.dart';
import 'package:example/services/models/bili_hot_video.dart';
import 'package:example/services/models/paging_bili_hot_video.dart';
import 'package:redstonex/redstonex.dart';

import 'bili_hot_video_state.dart';

class BiliHotVideoLogic extends PagingController<BiliHotVideo, BiliHotVideoPagingState> {
  final BiliHotVideoState state = BiliHotVideoState();
  final BiliService _biliService = XDepends().on();
  final BiliFavoriteVideoDao _biliFavoriteVideoDao = MyExampleDb().database.biliFavoriteVideoDao;

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
  }

  @override
  bool hasMoreData() {
    return state.biliHotVideoPagingState.hasMore;
  }

  @override
  Future<PagingData<BiliHotVideo>?> loadData(PagingParams pagingParams,
      {bool Function(ApiException)? onError}) async {
    PagingBiliHotVideo pagingBiliHotVideo = await _biliService.getBilibiliHotVideos(pagingParams);
    PagingData<BiliHotVideo> pagingData = PagingData();
    pagingData.data = pagingBiliHotVideo.list;
    pagingData.currentIndex = state.biliHotVideoPagingState.nextIndex;

    state.biliHotVideoPagingState.hasMore = !pagingBiliHotVideo.noMore;

    return pagingData;
  }

  @override
  PagingParams providePagingParams() {
    return PagingParams.create(
      pageIndex: state.biliHotVideoPagingState.nextIndex,
      pageSize: state.biliHotVideoPagingState.pageSize,
    );
  }

  @override
  BiliHotVideoPagingState providePagingState() {
    return state.biliHotVideoPagingState;
  }
}
