import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';

class LottieIndex extends LottieGetxBottomNavigationBarPage {
  LottieIndex({super.key}) : super(animationDuration: 3.seconds, iconHeight: 300);

  @override
  List<LottieBottomNavigationItem> getLottieBottomNavigationItems() {
    return [
      LottieBottomNavigationItem(label: 'book', index: 0, lottieJsonPath: 'assets/lottie/115882-glass-note.json'),
      LottieBottomNavigationItem(
          label: 'setting', index: 1, lottieJsonPath: 'assets/lottie/115556-price-tag.json'),
      LottieBottomNavigationItem(label: 'book', index: 2, lottieJsonPath: 'assets/lottie/115882-glass-note.json'),
      LottieBottomNavigationItem(
          label: 'setting', index: 3, lottieJsonPath: 'assets/lottie/115556-price-tag.json'),
    ];
  }

  @override
  List<Widget> getPages() {
    return [
      const TextEmptyPage(title: 'Book page'),
      const TextEmptyPage(title: 'Setting page'),
      const TextEmptyPage(title: 'Setting page'),
      const TextEmptyPage(title: 'Setting page'),
    ];
  }

  @override
  PreferredSizeWidget? appBar() {
    return RsxAppBar(title: 'Lottie', isBack: true);
  }
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
