import 'package:redstonex/net/exception/exception_handler.dart';
import 'package:redstonex/net/exception/net_exception.dart';
import 'package:redstonex/utils/loading_utils.dart';

class NetRequests {
  static Future load(
    Function() block, {
    bool showLoading = true,
    String? loadingText,
    bool Function(ApiException)? onError,
  }) async {
    try {
      await LoadingUtils.loadingProcess(
        block,
        isShowLoading: showLoading,
        loadingText: loadingText,
      );
    } catch (e) {
      handleException(ApiException.from(e), onError: onError);
    }
  }
}

class LocalRequests {
  static Future load(
    Function() block, {
    bool showLoading = true,
    String? loadingText,
    bool Function(ApiException)? onError,
  }) async {
    try {
      await LoadingUtils.loadingProcess(
        block,
        isShowLoading: showLoading,
        loadingText: loadingText,
      );
    } catch (e) {
      handleException(ApiException.from(e), onError: onError);
    }
  }
}

typedef ParallelRequestOnValue = void Function(dynamic value);

class ParallelRequest {
  final Future<dynamic> future;
  final ParallelRequestOnValue? onValue;

  ParallelRequest(this.future, {this.onValue});
}

class ParallelRequests {
  static Future load(
    List<ParallelRequest> requestFutures, {
    bool showLoading = true,
    String? loadingText,
    bool Function(ApiException)? onError,
  }) async {
    List<Future<dynamic>> futures = requestFutures.map((e) => e.future).toList();

    try {
      await LoadingUtils.loadingProcess(
        () => Future.wait<dynamic>(futures).then((value) {
          for (int i = 0; i < requestFutures.length; i++) {
            ParallelRequest pr = requestFutures[i];
            pr.onValue?.call(value[i]);
          }
        }),
        isShowLoading: showLoading,
        loadingText: loadingText,
      );
    } catch (e) {
      handleException(ApiException.from(e), onError: onError);
    }
  }
}
