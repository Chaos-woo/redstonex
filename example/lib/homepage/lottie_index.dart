import 'package:flutter/material.dart';
import 'package:redstonex/redstonex.dart';

class LottieIndex extends rLottieGetxBottomNavigationBarPage {
  LottieIndex({super.key}) : super(animationDuration: 3.seconds, iconHeight: 300);

  @override
  List<rLottieBottomNavigationItem> getLottieBottomNavigationItems() {
    return [
      rLottieBottomNavigationItem(label: 'book', index: 0, lottieJsonPath: 'assets/lottie/115882-glass-note.json'),
      rLottieBottomNavigationItem(
          label: 'setting', index: 1, lottieJsonPath: 'assets/lottie/115556-price-tag.json'),
      rLottieBottomNavigationItem(label: 'book', index: 2, lottieJsonPath: 'assets/lottie/115882-glass-note.json'),
      rLottieBottomNavigationItem(
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
    return AppBar(
      title: const Text('Lottie'),
      leading: rRsxClickWidget(
        child: const Icon(Icons.arrow_back_ios_new),
        onTap: () => rNavigator().back(),
      ),
    );
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
