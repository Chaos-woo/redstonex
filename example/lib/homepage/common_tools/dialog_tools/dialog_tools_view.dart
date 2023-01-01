import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:redstonex/redstonex.dart';

class DialogToolsComponent extends StatelessWidget {
  int flowerCount = 0;

  DialogToolsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OptionBarItem> ops = [
      _opItem('基本Dialog', '标题,描述,确认按钮', () {
        DialogUtils.showPromptDialog(
            title: '什么是Dialog?',
            content: 'dialog是在当前界面弹出的一个小窗口，用于显示重要提示信息。',
            textConfirm: 'Ok',
            confirmTextColor: Colors.blue,
            onConfirm: () {
              Navigators.back();
            });
      }),
      _opItem('处理事件Dialog', '标题,描述,确认按钮,取消按钮', () {
        DialogUtils.showPromptDialog(
            title: '删除?',
            content: '是否删除该条消息?',
            textConfirm: '确定',
            confirmTextColor: Colors.blue,
            onConfirm: () {
              ToastUtils.show('已删除');
              Navigators.back();
            },
            textCancel: '取消',
            cancelTextColor: Colors.grey,
            onCancel: () {
              Navigators.back();
            });
      }),
      _opItem('应用升级Dialog', '标题,描述,确认按钮,取消按钮', () {
        DialogUtils.showPromptDialog(title: '新版本来袭！', content: '应用发布了更多好看好玩的功能，快去应用市场更新吧~', actions: <Widget>[
          DialogUtils.textButton(text: '暂不提醒', onTap: () => Navigators.back(), textColor: Colors.grey),
          DialogUtils.dialogButton(
            text: '去升级 >>',
            onTap: () => Navigators.back(),
            buttonColor: Colors.blue,
            textColor: Colors.white,
          ),
        ]);
      }),
      _opItem('自定义Dialog', '自定义', () {
        DialogUtils.showElasticDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          title: Container(
            padding: EdgeInsets.zero,
            height: 63,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                    top: -63,
                    child: SizedBox(
                      width: 86,
                      height: 86,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(43.0)),
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    )),
                const Positioned(
                    top: -60,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: GFAvatar(
                        backgroundImage: NetworkImage('https://pic1.zhimg.com/50/v2-bc4cd78275421fbc79f362f011cbd265_hd.jpg?source=1940ef5c'),
                      ),
                    )),
                const Positioned(
                    top: 30,
                    child: Text(
                      'example_1211',
                      style: TextStyle(
                        fontSize: 14,
                          fontWeight: FontWeight.bold,
                      ),
                    )),
                const Positioned(
                    top: 48,
                    child: Text(
                      '这个人很懒，什么都没写',
                      style: TextStyle(color: Colors.grey, fontSize: 12,),
                    )),
              ],
            ),
          ),
          content: Container(
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _customStatisticsItem('经验值', 0),
                _customStatisticsItem('Ta的关注', 0),
                _customStatisticsItem('Ta的粉丝', 0),
                _customStatisticsItem('Ta的鲜花', flowerCount),
              ],
            ),
          ),
          actions: <Widget>[
            DialogUtils.textButton(
                text: '私信Ta',
                onTap: () {
                  ToastUtils.show('Ta似乎并不理你~');
                  Navigators.back();
                },
                textColor: Colors.grey),
            DialogUtils.dialogButton(
              text: '送Ta鲜花',
              onTap: () {
                flowerCount++;
                ToastUtils.show('送出鲜花1朵');
                Navigators.back();
              },
              buttonColor: Colors.red,
              textColor: Colors.white,
            ),
          ],
        );
      }),
    ];

    var obGroup = [ops];
    return GFAccordion(
      title: 'Dialog',
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

  Widget _customStatisticsItem(String label, int num) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$num',
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Gaps.vGap5,
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
