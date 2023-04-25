import 'package:example/services/bili_service.dart';
import 'package:example/services/models/bili_hot_video.dart';
import 'package:example/services/models/paging_bili_hot_video.dart';
import 'package:redstonex/redstonex.dart';

import 'bili_hot_video_state.dart';

class BiliHotVideoLogic extends PagingController<BiliHotVideo, BiliHotVideoPagingState> {
  final BiliHotVideoState state = BiliHotVideoState();
  final BiliService biliService = XDepends().on();

  @override
  bool hasMoreData() {
    return state.biliHotVideoPagingState.hasMore;
  }

  @override
  Future<PagingData<BiliHotVideo>?> loadData(PagingParams pagingParams,
      {bool Function(ApiException)? onError}) async {
    PagingBiliHotVideo pagingBiliHotVideo = await biliService.getBilibiliHotVideos(pagingParams);
    PagingData<BiliHotVideo> pagingData = PagingData();
    pagingData.data = pagingBiliHotVideo.list;
    pagingData.currentIndex = state.biliHotVideoPagingState.nextIndex;

    state.biliHotVideoPagingState.hasMore = !pagingBiliHotVideo.noMore;

    return pagingData;
  }

  @override
  PagingParams customPagingParams() {
    return PagingParams.create(
      pageIndex: state.biliHotVideoPagingState.nextIndex,
      pageSize: state.biliHotVideoPagingState.pageSize,
    );
  }

  @override
  BiliHotVideoPagingState customPagingState() {
    return state.biliHotVideoPagingState;
  }

  @override
  Future<void> beforeRefresh() async {
    biliService.loadLocalBiliVideosBVids();
  }
}
