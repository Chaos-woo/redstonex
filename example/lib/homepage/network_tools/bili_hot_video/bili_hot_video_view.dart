import 'package:example/homepage/network_tools/bili_hot_video/components/bili_hot_video_widget.dart';
import 'package:example/routes.dart';
import 'package:example/services/models/bili_hot_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

import 'bili_hot_video_logic.dart';

class BiliHotVideoPage extends StatelessWidget {
  final logic = rDepends().on<BiliHotVideoLogic>();
  final state = rDepends().on<BiliHotVideoLogic>().state;

  BiliHotVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: const Text('Bilibili综合热门视频'),
          leading: rClickWidget(
            child: const Icon(Icons.arrow_back_ios_new),
            onTap: () => rNavigator().back(),
          ),
          actions: [
            rClickWidget(
              child: const Icon(Icons.video_collection, color: Colors.blueGrey, size: 22),
              onTap: () {},
            ).padding(horizontal: 5),
            rClickWidget(
              child: Icon(Icons.star_border_rounded, color: Colors.yellow[700], size: 28),
              onTap: () => rNavigator().to(RouteCompose.biliRoute.favoriteVideos),
            ).padding(horizontal: 12),
          ],
        ),
        body: rRefreshableWidgets.buildRefreshableListWidget<BiliHotVideo, BiliHotVideoLogic>(
          itemBuilder: (Rx<BiliHotVideo> item, int index) => BiliHotVideoWidget(item: item),
          separatorBuilder: (item, index) => rGaps.vGap10,
          onItemClick: (item, index) => rNavigator().to(RouteCompose.biliRoute.videoDetail, parameters: {'url': item.value.shortLink}),
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        ).padding(vertical: 10, horizontal: 10).decorated(color: Colors.grey[200]),
      ),
    );
  }
}
