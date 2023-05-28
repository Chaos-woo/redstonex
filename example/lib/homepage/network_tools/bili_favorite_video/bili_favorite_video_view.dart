import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:example/homepage/network_tools/bili_favorite_video/components/bili_favorite_video_widget.dart';
import 'package:example/routes.dart';
import 'package:example/services/bili_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

import 'bili_favorite_video_logic.dart';

class BiliFavoriteVideoPage extends StatelessWidget {
  final logic = XDepends().on<BiliFavoriteVideoLogic>();
  final state = XDepends().on<BiliFavoriteVideoLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: const Text('Bilibili收藏视频'),
          leading: RsxClickWidget(
            child: const Icon(Icons.arrow_back_ios_new),
            onTap: () => XNavigator().back(),
          ),
        ),
        body: RefreshableWidgets.buildEventRefreshableListWidget<BiliFavoriteVideo, BiliFavoriteVideoLogic>(
          itemBuilder: (Rx<BiliFavoriteVideo> item, int index) => BiliFavoriteVideoWidget(item: item),
          separatorBuilder: (item, index) => Gaps.vGap10,
          onItemClick: (item, index) =>
              XNavigator().to(RouteCompose.biliRoute.videoDetail, parameters: {'url': item.value.shortLink}),
          onItemLongPress: (item, index) {
            XDialog().showActionDialog([
              TextButton(
                child: const Text('移除收藏'),
                onPressed: () async {
                  await XDepends().on<BiliService>().removeFavoriteBiliVideo(item.value.bVid);
                  logic.refreshData();
                  XToast().show('移除成功');
                },
              ),
            ],
                title: '视频：${item.value.title}',
                titleStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ));
          },
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        ).padding(vertical: 10, horizontal: 10).decorated(color: Colors.grey[200]),
      ),
    );
  }
}
