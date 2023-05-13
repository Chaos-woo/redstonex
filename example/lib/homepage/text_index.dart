// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
// import 'package:redstonex/redstonex.dart';
// import 'package:styled_widget/styled_widget.dart';
//
// class TextIndex extends RsxTextBottomNavigationBarPage {
//   @override
//   List<Widget> getPages() {
//     return [
//       const TextEmptyPage(title: 'Book page'),
//       const TextEmptyPage(title: 'Setting page1'),
//       const TextEmptyPage(title: 'Setting page2'),
//       const TextEmptyPage(title: 'Setting page3'),
//     ];
//   }
//
//   @override
//   PreferredSizeWidget? appBar() {
//     return RsxAppBar(
//       title: 'Persistent Bottom NavBar',
//       isBack: true,
//       actions: [
//         Obx(() {
//           if (selectedIndex.value == 0) {
//             return const Icon(
//               Icons.star_rounded,
//               size: 24,
//               color: Colors.yellow,
//             ).padding(right: 10);
//           }
//           return const SizedBox();
//         }),
//       ],
//     );
//   }
//
//   @override
//   List<PersistentBottomNavBarItem> getNavigationTabConfig() {
//     return [
//       PersistentBottomNavBarItem(icon: const Icon(Icons.abc), title: 'abc'),
//       PersistentBottomNavBarItem(icon: const Icon(Icons.settings), title: 'setting'),
//       PersistentBottomNavBarItem(icon: const Icon(Icons.pages), title: 'pages'),
//       PersistentBottomNavBarItem(icon: const Icon(Icons.one_k), title: '1K'),
//     ];
//   }
//
//   @override
//   NavBarStyle navBarDecoration() {
//     return NavBarStyle.style12;
//   }
// }
//
// class TextEmptyPage extends StatelessWidget {
//   final String title;
//
//   const TextEmptyPage({Key? key, required this.title}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       child: Center(
//         child: Text(title),
//       ),
//     );
//   }
// }
