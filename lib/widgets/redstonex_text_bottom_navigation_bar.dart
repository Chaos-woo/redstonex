import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../redstonex.dart';

/// 基于PersistentTabView带有BottomNavigation的页面导航
abstract class RsxTextBottomNavigationBarPage extends StatelessWidget
    implements RsxBottomNavigationBarPageScaffold {
  late final PersistentTabController _controller;
  var selectedIndex = 0.obs;

  RsxTextBottomNavigationBarPage({
    super.key,
    PersistentTabController? tabController,
  }) {
    _controller = tabController ?? PersistentTabController(initialIndex: 0);
    selectedIndex = _controller.index.obs;
  }

  List<PersistentTabConfig> getNavigationTabConfig();

  ScreenTransitionAnimation screenTransitionAnimation() => ScreenTransitionAnimation(
        curve: Curves.ease,
        duration: 200.microseconds,
      );

  Widget Function(NavBarConfig) navBarDecoration() => (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: const NavBarDecoration(),
      );

  ValueChanged<int>? onItemSelected() => null;

  double navBarHeight() => kBottomNavigationBarHeight;

  bool handleAndroidBackButtonPress() => true;

  bool resizeToAvoidBottomInset() => true;

  bool stateManagement() => true;

  bool popAllScreensOnTapOfSelectedTab() => true;

  bool popAllScreensOnTapAnyTabs() => true;

  EdgeInsets margin() => EdgeInsets.zero;

  Widget? drawerBuilder() => null;

  double? drawerEdgeDragWidth() => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: backgroundColor(),
      body: PersistentTabView(
        controller: _controller,
        tabs: getNavigationTabConfig(),
        backgroundColor: backgroundColor() ?? Colors.white,
        handleAndroidBackButtonPress: handleAndroidBackButtonPress(),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        stateManagement: stateManagement(),
        popAllScreensOnTapOfSelectedTab: popAllScreensOnTapOfSelectedTab(),
        popActionScreens: PopActionScreensType.all,
        margin: margin(),
        screenTransitionAnimation: screenTransitionAnimation(),
        navBarBuilder: navBarDecoration(),
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: floatingActionButtonLocation(),
        onTabChanged: (index) {
          selectedIndex.value = index;
          onItemSelected()?.call(index);
        },
        navBarHeight: navBarHeight(),
        popAllScreensOnTapAnyTabs: popAllScreensOnTapAnyTabs(),
        drawer: drawerBuilder(),
        drawerEdgeDragWidth: drawerEdgeDragWidth(),
      ),
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
