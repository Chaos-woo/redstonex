import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redstonex/resources/dimens.dart';
import 'package:redstonex/resources/gaps.dart';
import 'package:redstonex/utils/theme_utils.dart';
import 'package:redstonex/widgets/redstonex_button.dart';

/// 自定义AppBar
class RsxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RsxAppBar({
    super.key,
    this.leadingWidget,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.titleColor,
    this.customTitleWidget,
    this.actionName = '',
    this.onPressed,
    this.isBack = true,
  });

  final Widget? leadingWidget;
  final Color? backgroundColor;

  final String title;
  final String centerTitle;
  final Color? titleColor;

  final Widget? customTitleWidget;

  final String actionName;
  final VoidCallback? onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? context.backgroundColor;

    final SystemUiOverlayStyle overlayStyle = ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    final Widget action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: const ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 60.0,
                ),
              ),
              child: RsxButton(
                key: const Key('actionName'),
                fontSize: Dimens.fontSp14,
                minWidth: null,
                text: actionName,
                textColor: ThemeUtils.theme().appBarTheme.titleTextStyle?.color,
                backgroundColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : Gaps.emptyBox;

    final Widget leadingWidget = isBack
        ? IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              final isBack = await Navigator.maybePop(context);
              if (!isBack) {
                await SystemNavigator.pop();
              }
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: Icon(Icons.arrow_back_ios, color: titleColor,),
          )
        : this.leadingWidget ?? Gaps.emptyBox;

    final Widget titleWidget = customTitleWidget ?? Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: TextStyle(
            fontSize: Dimens.fontSp18,
            color: titleColor,
          ),
        ),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: bgColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              leadingWidget,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
