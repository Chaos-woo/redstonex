import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../redstonex.dart';

abstract class RsxTextBottomNavigationBarPage extends StatelessWidget
    implements RsxBottomNavigationBarPageScaffold {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  var selectedIndex = 0.obs;

  RsxTextBottomNavigationBarPage({
    super.key,
  });

  List<Widget> getPages();

  // 配置参考：https://pub.dev/packages/persistent_bottom_nav_bar_v2
  List<PersistentBottomNavBarItem> getNavigationItems();

  ItemAnimationProperties itemAnimationProperties() => ItemAnimationProperties(
        duration: 200.microseconds,
        curve: Curves.ease,
      );

  ScreenTransitionAnimation screenTransitionAnimation() => ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: 200.microseconds,
      );

  NavBarStyle navBarStyle() => NavBarStyle.style1;

  NavBarDecoration navBarDecoration() => const NavBarDecoration();

  ValueChanged<int>? onItemSelected() => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: backgroundColor(),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: getPages(),
        items: getNavigationItems(),
        confineInSafeArea: true,
        backgroundColor: backgroundColor() ?? Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: navBarDecoration(),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: itemAnimationProperties(),
        screenTransitionAnimation: screenTransitionAnimation(),
        navBarStyle: navBarStyle(),
        onItemSelected: (index) {
          selectedIndex.value = index;
          onItemSelected()?.call(index);
        },
      ),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: floatingActionButtonLocation(),
    );
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget? floatingActionButton() => null;

  @override
  FloatingActionButtonLocation? floatingActionButtonLocation() => null;

  @override
  Color? selectedItemColor() => null;

  @override
  Color? unselectedItemColor() => null;

  @override
  Color? backgroundColor() => null;
}
