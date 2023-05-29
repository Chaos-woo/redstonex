import '../utils/loading.dart';
import 'exception/api_exception.dart';
import 'exception/exception_handler.dart';

class rSyncLoader {
  static Future execute(
    Function() block, {
    bool showLoading = true,
    String? loadingText,
    bool Function(rApiException)? onError,
  }) async {
    try {
      await rLoading().loading(
        block,
        isShowLoading: showLoading,
        loadingText: loadingText,
      );
    } catch (e) {
      handleException(rApiException.from(e), onError: onError);
    }
  }
}

typedef ParallelRequestOnValue = void Function(dynamic value);

class ParallelRequest {
  final Future<dynamic> future;
  final ParallelRequestOnValue? onValue;

  ParallelRequest(this.future, {this.onValue});
}

class rParallelLoader {
  static Future execute(
    List<ParallelRequest> loaderFutures, {
    bool showLoading = true,
    String? loadingText,
    bool Function(rApiException)? onError,
  }) async {
    List<Future<dynamic>> futures = loaderFutures.map((e) => e.future).toList();

    try {
      await rLoading().loading(
        () => Future.wait<dynamic>(futures).then((value) {
          for (int i = 0; i < loaderFutures.length; i++) {
            ParallelRequest pr = loaderFutures[i];
            pr.onValue?.call(value[i]);
          }
        }),
        isShowLoading: showLoading,
        loadingText: loadingText,
      );
    } catch (e) {
      handleException(rApiException.from(e), onError: onError);
    }
  }
}
