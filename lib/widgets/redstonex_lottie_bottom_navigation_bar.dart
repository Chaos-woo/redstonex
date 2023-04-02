import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:redstonex/widgets/redstonex_getx_bottom_navigation_bar.dart';

class LottieBottomNavigationItem {
  final String label;
  final String lottieJsonPath;
  final int index;

  LottieBottomNavigationItem({required this.label, required this.lottieJsonPath, required this.index});
}

abstract class LottieGetxBottomNavigationBarPage extends HookWidget implements RsxBottomNavigationBarPageScaffold {
  int currentIndex = 0;

  Duration animationDuration;
  PageChangeType pageChangeType;
  Duration pageChangeAnimateDuration;
  final double iconHeight;
  bool showSelectedLabels;
  bool showUnselectedLabels;

  LottieGetxBottomNavigationBarPage({
    super.key,
    required this.animationDuration,
    required this.iconHeight,
    this.pageChangeAnimateDuration = const Duration(microseconds: 300),
    this.pageChangeType = PageChangeType.jump,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  });

  List<LottieBottomNavigationItem> getLottieBottomNavigationItems();

  List<Widget> getPages();

  @override
  Widget build(BuildContext context) {
    final idleAnimationController = useAnimationController();
    final onSelectedAnimationController = useAnimationController(duration: animationDuration);
    final onChangedAnimationController = useAnimationController(duration: animationDuration);

    return RsxBottomNavigationBarPage(
      showUnselectedLabels: showUnselectedLabels,
      showSelectedLabels: showSelectedLabels,
      pageChangeAnimateDuration: pageChangeAnimateDuration,
      pageChangeType: pageChangeType,
      backgroundColor: backgroundColor(),
      unselectedItemColor: unselectedItemColor(),
      selectedItemColor: selectedItemColor(),
      appBar: appBar(),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: floatingActionButtonLocation(),
      pages: getPages(),
      navigationItemsProvider: (preSelectedIndex, selectedIndex) => getLottieBottomNavigationItems()
          .map(
            (item) => BottomNavigationBarItem(
              tooltip: '',
              icon: SizedBox(
                height: (!showSelectedLabels && !showUnselectedLabels) ? 0 : 16,
                child: OverflowBox(
                  minHeight: 80,
                  maxHeight: 80,
                  child: Lottie.asset(
                    item.lottieJsonPath,
                    fit: BoxFit.fill,
                    controller: selectedIndex == item.index
                        ? onSelectedAnimationController
                        : preSelectedIndex == item.index
                            ? onChangedAnimationController
                            : idleAnimationController,
                  ),
                ),
              ),
              label: item.label,
            ),
          )
          .toList(),
      changed: (selectedIndex) {
        currentIndex = selectedIndex;

        onSelectedAnimationController.reset();
        onSelectedAnimationController.forward();

        onChangedAnimationController.value = 1;
        onChangedAnimationController.reverse();
      },
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
