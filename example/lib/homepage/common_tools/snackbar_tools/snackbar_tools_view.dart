import 'package:example/widgets/rsx_option_item_utils.dart';
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
    var optionItems = [
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '基本SnackBar',
        description: _desc,
        onTap: () {
          rSnackBar().showPromptSnackBar(message: _messageString);
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '无标题SnackBar',
        description: _iconDesc,
        onTap: () {
          rSnackBar().showPromptSnackBar(
              message: _messageString,
              icon: const Icon(
                Icons.image,
                color: Colors.grey,
              ));
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '全提示性SnackBar',
        description: _iconTitleDesc,
        onTap: () {
          rSnackBar().showPromptSnackBar(
            title: _titleString,
            message: _messageString,
            icon: const Icon(
              Icons.image,
              color: Colors.grey,
            ),
          );
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '可点击的SnackBar',
        description: _iconDesc,
        onTap: () {
          rSnackBar().showPromptSnackBar(
            message: _messageString,
            icon: const Icon(
              Icons.image,
              color: Colors.grey,
            ),
            lightButton: rSnackBar().snackBarAction('Close', onTap: () {
              rSnackBar().closeCurrentSnackBar();
            }, textStyle: const TextStyle(color: Colors.green)),
          );
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '超长文字的SnackBar',
        description: _iconDesc,
        onTap: () {
          rSnackBar().showPromptSnackBar(
            message: _longTextString,
            icon: const Icon(
              Icons.image,
              color: Colors.grey,
            ),
            lightButton: rSnackBar().snackBarAction('Close',
                textStyle: const TextStyle(
                  color: Colors.lightBlue,
                ), onTap: () {
              rSnackBar().closeCurrentSnackBar();
            }),
          );
        },
      ),
      RsxOptionItemUtils.functionRsxOptionItem(
        title: '超长标题和文字的SnackBar',
        description: _iconTitleDesc,
        onTap: () {
          rSnackBar().showPromptSnackBar(
            title: _longTextString,
            message: _longTextString,
            icon: const Icon(
              Icons.image,
              color: Colors.grey,
            ),
          );
        },
      ),
    ];

    var optionGroupItems = rOptionGroupItem(
      optionItems: optionItems,
      toolbar: rHorizontalToolbar(
        label: 'General',
        labelStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );

    return GFAccordion(
      title: 'Snackbar',
      contentChild: rOptionGroupWidget(
        optionGroupItems: [optionGroupItems],
        physics: const NeverScrollableScrollPhysics(),
      ),
      margin: EdgeInsets.zero,
      collapsedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      expandedTitleBackgroundColor: Colors.grey.withOpacity(0.1),
      showAccordion: false,
      titleBorderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      contentBorderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
    );
  }
}
