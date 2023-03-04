import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class RsxVerticalScrollView extends StatelessWidget {
  RsxVerticalScrollView({
    Key? key,
    this.children = const [],
    this.scrollViewPadding,
    this.physics = const BouncingScrollPhysics(),
    this.childrenCrossAxisAlignment = CrossAxisAlignment.start,
    this.topWidget,
    this.bottomWidget,
    this.keyboardConfig,
    this.tapOutsideToDismiss = false,
    this.overScroll = 16.0,
  }) : super(key: key);

  List<Widget> children;
  EdgeInsetsGeometry? scrollViewPadding;
  ScrollPhysics physics;
  CrossAxisAlignment childrenCrossAxisAlignment;
  Widget? topWidget;
  Widget? bottomWidget;
  KeyboardActionsConfig? keyboardConfig;

  /// 键盘外部按下将其关闭
  bool tapOutsideToDismiss;

  /// 默认弹起位置在TextField的文字下面，可以添加此属性继续向上滑动一段距离。用来露出完整的TextField。
  double overScroll;

  @override
  Widget build(BuildContext context) {
    Widget contents = Column(
      crossAxisAlignment: childrenCrossAxisAlignment,
      children: children,
    );

    if (defaultTargetPlatform == TargetPlatform.iOS && keyboardConfig != null) {
      /// iOS 键盘处理

      if (scrollViewPadding != null) {
        contents = Padding(padding: scrollViewPadding!, child: contents);
      }

      contents = KeyboardActions(
          isDialog: bottomWidget != null,
          overscroll: overScroll,
          config: keyboardConfig!,
          tapOutsideBehavior: tapOutsideToDismiss ? TapOutsideBehavior.opaqueDismiss : TapOutsideBehavior.none,
          child: contents);
    } else {
      contents = SingleChildScrollView(
        padding: scrollViewPadding,
        physics: physics,
        child: contents,
      );
    }

    if (null != topWidget || null != bottomWidget) {
      contents = Column(
        children: <Widget>[
          if (null != topWidget) SafeArea(child: topWidget!),
          Expanded(child: contents),
          if (null != bottomWidget) SafeArea(child: bottomWidget!),
        ],
      );
    }

    return contents;
  }
}
