import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:redstonex/redstonex.dart';
import 'package:styled_widget/styled_widget.dart';

class TextIndex extends rTextBottomNavigationBarPage {
  @override
  List<PersistentTabConfig> getNavigationTabConfig() {
    return <PersistentTabConfig>[
      // Feed/Rss订阅项
      PersistentTabConfig(
        screen: TextEmptyPage(title: 'Book page3'),
        item: ItemConfig(
          icon: const Icon(Icons.rss_feed_rounded),
          inactiveIcon: const Icon(Icons.rss_feed_rounded),
          title: 'feed',
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blue[300]!,
        ),
      ),
      // 综合项
      PersistentTabConfig(
        screen: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => Text('$index'),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.other_houses_outlined),
          inactiveIcon: const Icon(Icons.other_houses_rounded),
          title: 'others',
          activeColorPrimary: Colors.deepOrange,
          inactiveColorPrimary: Colors.deepOrange[300]!,
        ),
      ),
      // 应用设置项
      PersistentTabConfig(
        screen: TextEmptyPage(title: 'Book page1'),
        item: ItemConfig(
          icon: const Icon(Icons.settings_rounded),
          inactiveIcon: const Icon(Icons.settings_outlined),
          title: 'mine',
          activeColorPrimary: Colors.green,
          inactiveColorPrimary: Colors.green[300]!,
        ),
      ),
      PersistentTabConfig(
        screen: TextEmptyPage(title: 'Book page14'),
        item: ItemConfig(
          icon: const Icon(Icons.settings_rounded),
          inactiveIcon: const Icon(Icons.settings_outlined),
          title: 'mine2',
          activeColorPrimary: Colors.green,
          inactiveColorPrimary: Colors.green[300]!,
        ),
      ),
    ];
  }

  @override
  Widget Function(NavBarConfig) navBarDecoration() => (navBarConfig) => Style12BottomNavBar(
      navBarConfig: navBarConfig,
      navBarDecoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ));

  @override
  PreferredSizeWidget? appBar() {
    return AppBar(
      title: const Text('Persistent Bottom NavBar'),
      leading: rRsxClickWidget(
        child: const Icon(Icons.arrow_back_ios_new),
        onTap: () => rNavigator().back(),
      ),
      actions: [
        Obx(() {
          if (selectedIndex.value == 0) {
            return const Icon(
              Icons.star_rounded,
              size: 24,
              color: Colors.yellow,
            ).padding(right: 10);
          }
          return const SizedBox();
        }),
      ],
    );
  }

  @override
  Widget? floatingActionButton() => CircleAvatar(
        child: Icon(Icons.abc),
      ).paddingAll(60);

  @override
  FloatingActionButtonLocation? floatingActionButtonLocation() => FloatingActionButtonLocation.endDocked;
}

class TextEmptyPage extends StatelessWidget {
  final String title;

  const TextEmptyPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(title),
      ),
    );
  }
}
