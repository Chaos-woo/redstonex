import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_widget/styled_widget.dart';

import '../paging/utils/navigators.dart';
import '../resources/dimens.dart';
import '../resources/gaps.dart';
import '../utils/theme.dart';

/// 自定义AppBar
class RsxAppBar extends StatelessWidget implements PreferredSizeWidget {
  RsxAppBar({
    Key? key,
    this.leading,
    this.isBack = false,
    this.backIcon,
    this.backIconSize = 18.0,
    this.title,
    this.centerTitle,
    this.titleTextSize = Dimens.fontSp18,
    this.customTitleWidget,
    this.actions = const [],
    this.backgroundColor,
    this.frontColor,
    this.preferredHeight = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
  }) : super(key: key);

  Widget? leading;
  bool isBack;
  IconData? backIcon;
  double? backIconSize;

  String? title;
  String? centerTitle;
  double? titleTextSize;
  Widget? customTitleWidget;

  List<Widget> actions;

  double? preferredHeight;
  Color? backgroundColor;
  Color? frontColor;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? context.backgroundColor;

    var bgColorDarkMode = ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark;
    final SystemUiOverlayStyle overlayStyle =
        bgColorDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    frontColor = frontColor ?? (bgColorDarkMode ? Colors.white : Colors.black);

    final Widget actionWidget = actions.isNotEmpty
        ? actions
            .toRow(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
            )
            .positioned(right: 0.0)
        : Gaps.emptyBox;

    final Widget leadingWidget = isBack
        ? IconButton(
            iconSize: backIconSize!,
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final isBack = await Navigator.maybePop(context);
              if (!isBack) {
                XNavigator().back();
              }
            },
            tooltip: 'Back',
            icon: Icon(
              backIcon ?? Icons.arrow_back_ios,
              color: frontColor,
            ),
          )
        : leading ?? Gaps.emptyBox;

    final Widget titleWidget = customTitleWidget ??
        Semantics(
          namesRoute: true,
          header: true,
          child: Text(title ?? centerTitle ?? '',
                  style: TextStyle(
                    fontSize: titleTextSize,
                    color: frontColor,
                  ))
              .width(double.infinity)
              .alignment(
                centerTitle != null ? Alignment.centerLeft : Alignment.center,
              )
              .padding(horizontal: 48.0),
        );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: bgColor,
        child: SafeArea(
          child: <Widget>[
            titleWidget,
            leadingWidget,
            actionWidget,
          ].toStack(alignment: Alignment.centerLeft),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight ?? 48.0);
}
