import 'package:flutter/material.dart';
import 'package:redstonex/resources/dimens.dart';
import 'package:redstonex/resources/gaps.dart';

class ClickItem extends StatelessWidget {
  const ClickItem(
      {super.key,
      this.onTap,
      required this.title,
      this.content = '',
      this.textAlign = TextAlign.start,
      this.maxLines = 1});

  final GestureTapCallback? onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      //为了数字类文字居中
      crossAxisAlignment: maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        Text(title),
        const Spacer(),
        Gaps.hGap16,
        Expanded(
          flex: 4,
          child: Text(
            content,
            maxLines: maxLines,
            textAlign: maxLines == 1 ? TextAlign.right : textAlign,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.fontSp14),
          ),
        ),
        Gaps.hGap8,
        Opacity(
          // 无点击事件时，隐藏箭头图标
          opacity: onTap == null ? 0 : 1,
          child: Padding(
            padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
            child: const Icon(Icons.arrow_forward_ios),
          ),
        )
      ],
    );

    /// 分隔线
    child = Container(
      margin: const EdgeInsets.only(left: 15.0),
      padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
      constraints: const BoxConstraints(
        minHeight: 50.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        ),
      ),
      child: child,
    );

    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
