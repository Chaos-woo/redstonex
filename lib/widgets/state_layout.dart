import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redstonex/res/dimens.dart';
import 'package:redstonex/res/gaps.dart';
import 'package:redstonex/utils/theme_utils.dart';
import 'package:redstonex/widgets/load_image.dart';

class StateLayout extends StatelessWidget {
  const StateLayout({
    super.key,
    required this.type,
    this.hintText,
    this.emptyStateImg = '',
  });

  final StateType type;
  final String emptyStateImg;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (type == StateType.loading)
          const CupertinoActivityIndicator(radius: 16.0)
        else if (type == StateType.empty && emptyStateImg.isNotEmpty)
          Opacity(
            opacity: context.isDark ? 0.5 : 1,
            child: LoadAssetImage(
              emptyStateImg,
              width: 120,
            ),
          ),
        const SizedBox(
          width: double.infinity,
          height: Dimens.gapDp16,
        ),
        Text(
          hintText ?? '',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.fontSp14),
        ),
        Gaps.vGap50,
      ],
    );
  }
}

enum StateType {
  /// 加载中
  loading,

  /// 空
  empty
}
