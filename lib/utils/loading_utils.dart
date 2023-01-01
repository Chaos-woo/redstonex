import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingUtils {
  static Future loadingProcess(
    Function block, {
    bool isShowLoading = true,
    String? loadingText,
  }) async {
    if (isShowLoading) {
      showLoading();
    }
    try {
      await block();
    } catch (e) {
      rethrow;
    } finally {
      dismissLoading();
    }
    return;
  }

  static void showLoading({
    String loadingText = 'loading...',
  }) {
    EasyLoading.show(status: loadingText);
  }

  static void dismissLoading() {
    EasyLoading.dismiss();
  }
}
