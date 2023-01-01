import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

class SnackbarToolsComponent extends StatelessWidget {
  static const String _titleString = '什么是Snackbar?';
  static const String _messageString = 'Snackbar 是一种针对操作的轻量级反馈机制';
  static const String _longTextString = 'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW';

  static const String _icon = '图标';
  static const String _title = '标题';
  static const String _desc = '描述';
  static const String _iconTitle = '$_icon,$_title';
  static const String _iconTitleDesc = '$_iconTitle,$_desc';
  static const String _iconDesc = '$_icon,$_desc';

  const SnackbarToolsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OptionBarItem> ops = [
      _opItem('基本SnackBar', _desc, () {
        SnackBarUtils.showPromptSnackBar(message: _messageString);
      }),
      _opItem('无标题SnackBar', _iconDesc, () {
        SnackBarUtils.showPromptSnackBar(
            message: _messageString,
            icon: const Icon(
              Icons.image,
              color: Colors.grey,
            ));
      }),
      _opItem('全提示性SnackBar', _iconTitleDesc, () {
        SnackBarUtils.showPromptSnackBar(
          title: _titleString,
          message: _messageString,
          icon: const Icon(
            Icons.image,
            color: Colors.grey,
          ),
        );
      }),
      _opItem('可点击的SnackBar', _iconDesc, () {
        SnackBarUtils.showPromptSnackBar(
          message: _messageString,
          icon: const Icon(
            Icons.image,
            color: Colors.grey,
          ),
          lightButton: SnackBarUtils.snackBarAction('Close', onTap: () {
            SnackBarUtils.closeCurrentSnackBar();
          }, textStyle: const TextStyle(color: Colors.green)),
        );
      }),
      _opItem('超长文字的SnackBar', _iconDesc, () {
        SnackBarUtils.showPromptSnackBar(
          message: _longTextString,
          icon: const Icon(
            Icons.image,
            color: Colors.grey,
          ),
          lightButton: SnackBarUtils.snackBarAction('Close',
              textStyle: const TextStyle(
                color: Colors.lightBlue,
              ), onTap: () {
            SnackBarUtils.closeCurrentSnackBar();
          }),
        );
      }),
      _opItem('超长标题和文字的SnackBar', _iconTitleDesc, () {
        SnackBarUtils.showPromptSnackBar(
          title: _longTextString,
          message: _longTextString,
          icon: const Icon(
            Icons.image,
            color: Colors.grey,
          ),
        );
      },),
    ];

    var obGroup = [ops];
    return GFAccordion(
      title: 'Snackbar',
      contentChild: OptionBarGroup(optionBarItemGroups: obGroup),
      margin: EdgeInsets.zero,
      collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      showAccordion: false,
    );
  }

  OptionBarItem _opItem(String label, String? description, VoidCallback onTap) {
    return OptionBarItem(
      label,
      leadingIcon: Icons.touch_app,
      leadingIconColor: ThemeUtils.theme().iconTheme.color,
      subTitle: description,
      subTitleColor: ThemeUtils.theme().textTheme.bodyText1?.color,
      onTap: onTap,
    );
  }
}
