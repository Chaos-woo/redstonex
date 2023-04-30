import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../paging/utils/provides.dart';

typedef BottomNavigationBarItemChanged = void Function(int selectedIndex);
typedef BottomNavigationBarItemProvider = List<BottomNavigationBarItem> Function(
    int preSelctedIndex, int selectedIndex);

enum PageChangeType { jump, animate }

class RsxBottomNavigationBarPage extends StatelessWidget {
  final logic = XProvides().provide(_RsxBaseBottomNavigationLogic());
  final List<Widget> pages;
  final BottomNavigationBarItemProvider navigationItemsProvider;
  final PageController pageController = PageController();

  BottomNavigationBarItemChanged? changed;
  PreferredSizeWidget? appBar;
  Widget? floatingActionButton;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  Color? selectedItemColor;
  Color? unselectedItemColor;
  Color? backgroundColor;
  PageChangeType pageChangeType;
  Duration pageChangeAnimateDuration;
  bool showSelectedLabels;
  bool showUnselectedLabels;

  RsxBottomNavigationBarPage({
    super.key,
    required this.navigationItemsProvider,
    required this.pages,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.backgroundColor,
    this.changed,
    this.pageChangeType = PageChangeType.jump,
    this.pageChangeAnimateDuration = const Duration(microseconds: 300),
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: Obx(() => Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              items:
                  navigationItemsProvider.call(logic.preSelectedIndex, logic.selectedIndex.value),
              currentIndex: logic.selectedIndex.value,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: selectedItemColor,
              unselectedItemColor: unselectedItemColor,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              showSelectedLabels: showSelectedLabels,
              showUnselectedLabels: showUnselectedLabels,
              backgroundColor: backgroundColor,
              onTap: (int index) {
                changed?.call(index);

                logic.preSelectedIndex = logic.selectedIndex.value;
                logic.selectedIndex.value = index;
                if (pageChangeType == PageChangeType.jump) {
                  pageController.jumpToPage(index);
                } else {
                  pageController.animateToPage(index,
                      duration: pageChangeAnimateDuration, curve: Curves.ease);
                }
              },
            ),
          )),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}

class _RsxBaseBottomNavigationLogic extends GetxController {
  var selectedIndex = 0.obs;
  var preSelectedIndex = 0;
}

abstract class RsxBottomNavigationBarPageScaffold {
  PreferredSizeWidget? appBar();

  Widget? floatingActionButton();

  FloatingActionButtonLocation? floatingActionButtonLocation();

  Color? selectedItemColor();

  Color? unselectedItemColor();

  Color? backgroundColor();
}
