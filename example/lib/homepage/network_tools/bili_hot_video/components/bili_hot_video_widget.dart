import 'package:common_utils/common_utils.dart';
import 'package:example/services/models/bili_hot_video.dart';
import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

class BiliHotVideoWidget extends StatefulWidget {
  final BiliHotVideo item;

  const BiliHotVideoWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<BiliHotVideoWidget> createState() => _BiliHotVideoWidgetState();
}

class _BiliHotVideoWidgetState extends State<BiliHotVideoWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) => <Widget>[
        _renderVideoMainContent(),
        Gaps.vGap5,
        _renderVideoStats(),
        const Divider(),
        _renderOperateTabs(boxConstraints),
      ]
          .toColumn(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          )
          .padding(all: 10)
          .decorated(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 2, offset: const Offset(2, 2))
        ],
      ).padding(horizontal: 4),
    );
  }

  Widget _renderVideoMainContent() {
    return <Widget>[
      <Widget>[
        Text(
          widget.item.tagName,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ).padding(horizontal: 5).backgroundColor(Colors.green[400]!),
        if (!widget.item.recommendReason.content.oNullOrBlank)
          Text(
            '推荐理由: ${widget.item.recommendReason.content}',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ).padding(horizontal: 5).backgroundColor(Colors.orange)
      ].toWrap(spacing: 5, runSpacing: 5),
      Gaps.vGap5,
      <Widget>[
        AspectRatio(
          aspectRatio: 1.5,
          child: RsxImageLoader(
            widget.item.pic,
            fit: BoxFit.cover,
            holderImg: 'assets/images/bg/image_holder.png',
          ),
        ).height(75).clipRRect(all: 10),
        Gaps.hGap5,
        <Widget>[
          Text(
            widget.item.title,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Gaps.vGap4,
          <Widget>[
            CircleAvatar(
              radius: 8,
              foregroundImage: XImage().getHolderImageNetProvider(widget.item.owner.face),
            ),
            Gaps.hGap4,
            Text(
              widget.item.owner.name,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.start),
          const Spacer(),
          <Widget>[
            const Text(
              '发布时间: ',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
            Gaps.hGap4,
            Text(
              TimelineUtil.format(
                widget.item.pubDate * 1000,
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
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).height(75),
    ].toColumn(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget _renderVideoStats() {
    var stat = widget.item.stats;
    var displayVideoStats = [
      {'name': '播放', 'stat': stat.view},
      {'name': '弹幕', 'stat': stat.danmaku},
      {'name': '回复', 'stat': stat.reply},
      {'name': '收藏', 'stat': stat.favorite},
      {'name': '硬币', 'stat': stat.coin},
      {'name': '分享', 'stat': stat.share},
      {'name': '点赞', 'stat': stat.like},
    ];
    Widget styledSingleStatWidget(Widget child) => Styled.widget(child: child);

    return GridView.builder(
      shrinkWrap: true,
      itemCount: displayVideoStats.length,
      itemBuilder: (context, index) {
        var displayStat = displayVideoStats[index];
        var statTextStyle = const TextStyle(
          fontSize: 10,
          color: Colors.grey,
        );
        var statWidget = <Widget>[
          Text(
            '${displayStat['name']}',
            style: statTextStyle,
          ),
          Text(
            ': ',
            style: statTextStyle,
          ),
          Text(
            XCompactNumber().compact((displayStat['stat']) as int),
            style: statTextStyle,
          ),
        ].toRow(mainAxisSize: MainAxisSize.min);
        return styledSingleStatWidget(statWidget);
      },
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 5 / 0.6,
        crossAxisCount: 3,
      ),
    );
  }

  Widget _renderOperateTabs(BoxConstraints boxConstraints) {
    double tabWidth = boxConstraints.maxWidth / 2 - 30;
    Widget styledWidget(Widget child) => Styled.widget(child: child).center().width(tabWidth);
    return <Widget>[
      styledWidget(_renderOperateTab(text: '稍后再看', icon: Icons.history, color: Colors.blueAccent, onTap: () {})),
      Gaps.vLine(),
      styledWidget(_renderOperateTab(text: '收藏', icon: Icons.star_border_rounded, color: Colors.blueAccent, onTap: () {})),
    ].toRow(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget _renderOperateTab({required String text, required IconData icon, required Color color, VoidCallback? onTap,}) {
    var textStyle = TextStyle(
      fontSize: 14,
      color: Colors.blue[200],
    );
    return RsxClickWidget(
      onTap: onTap,
      child: <Widget>[
        Icon(icon, size: 17, color: color,),
        Gaps.hGap5,
        Text(
          text,
          style: textStyle,
        )
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
