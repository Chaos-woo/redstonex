import 'package:flutter_easyloading/flutter_easyloading.dart';

class XLoading {
  static final XLoading _single = XLoading.internal();

  XLoading.internal();

  factory XLoading() => _single;

  Future loading(
    Function block, {
    bool isShowLoading = true,
    String? loadingText,
  }) async {
    if (isShowLoading) {
      show();
    }
    try {
      await block();
    } catch (e) {
      rethrow;
    } finally {
      dismissAll();
    }
    return;
  }

  void show({
    String loadingText = 'loading...',
  }) {
    EasyLoading.show(status: loadingText);
  }

  void dismissAll() {
    EasyLoading.dismiss();
  }
}
