import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:example/services/bili_service.dart';
import 'package:redstonex/redstonex.dart';

import 'bili_favorite_video_state.dart';

class BiliFavoriteVideoLogic extends EventPagingController<BiliFavoriteVideo, BiliFavoriteVideoPagingState,
    BiliFavoriteVideoListRefreshableEvent<BiliFavoriteVideo>> {
  final BiliFavoriteVideoState state = BiliFavoriteVideoState();
  final BiliService _biliService = XDepends().on();

  @override
  bool hasMoreData() {
    return false;
  }

  @override
  Future loadData(PagingParams pagingParams) async {
    _biliService.pagingFavoriteBiliVideos(pagingParams.extra?['minId'] as int, pagingParams.size);
  }

  @override
  PagingParams customPagingParams() {
    int minId =
        state.biliFavoriteVideoPagingState.data.isEmpty ? -1 : state.biliFavoriteVideoPagingState.data.last.value.id!;
    return PagingParams.create(
        pageIndex: state.biliFavoriteVideoPagingState.nextIndex,
        pageSize: state.biliFavoriteVideoPagingState.pageSize,
        extra: {
          'minId': minId,
        });
  }

  @override
  BiliFavoriteVideoPagingState customPagingState() {
    return state.biliFavoriteVideoPagingState;
  }
}
