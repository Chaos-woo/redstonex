import 'package:common_utils/common_utils.dart';
import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

class BiliFavoriteVideoWidget extends StatefulWidget {
  final Rx<BiliFavoriteVideo> item;

  const BiliFavoriteVideoWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<BiliFavoriteVideoWidget> createState() => _BiliFavoriteVideoWidgetState();
}

class _BiliFavoriteVideoWidgetState extends State<BiliFavoriteVideoWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget styledWidget(Widget child) => Styled.widget(child: child).padding(horizontal: 5, vertical: 3);

    Widget mainContentWidget = <Widget>[
      AspectRatio(
        aspectRatio: 1.5,
        child: rImageLoader(
          widget.item.value.pic,
          fit: BoxFit.cover,
          holderImg: 'assets/images/bg/image_holder.png',
        ),
      ).height(75).clipRRect(all: 10),
      rGaps.hGap8,
      <Widget>[
        Text(
          widget.item.value.title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        rGaps.vGap4,
        <Widget>[
          const Text(
            'UP',
            style: TextStyle(fontSize: 8, color: Colors.grey, fontWeight: FontWeight.bold),
          ).padding(all: 1.5).decorated(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
          rGaps.hGap(2),
          Text(
            widget.item.value.up,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ].toRow(mainAxisAlignment: MainAxisAlignment.start),
        <Widget>[
          const Text(
            '发布时间: ',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
          rGaps.hGap4,
          Text(
            TimelineUtil.format(
              widget.item.value.publishData.millisecondsSinceEpoch,
              locTimeMs: DateTime.now().millisecondsSinceEpoch,
              locale: 'zh_normal',
              dayFormat: DayFormat.Full,
            ),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ].toRow(mainAxisAlignment: MainAxisAlignment.start),
      ]
          .toColumn(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .expanded(),
    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).height(80);

    return styledWidget(mainContentWidget);
  }

  @override
  bool get wantKeepAlive => true;
}
