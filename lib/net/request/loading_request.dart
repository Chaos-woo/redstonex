import 'package:redstonex/net/exception/exception_handler.dart';
import 'package:redstonex/net/exception/net_exception.dart';
import 'package:redstonex/utils/loading_utils.dart';

class Requests {
  static Future loadingRequest(
    Function() block, {
    bool showLoading = true,
    String? loadingText,
    bool Function(ApiException)? onError,
  }) async {
    try {
      await LoadingUtils.loadingRequest(
        block,
        isShowLoading: showLoading,
        loadingText: loadingText,
      );
    } catch (e) {
      handleException(ApiException.from(e), onError: onError);
    }
    return;
  }
}
