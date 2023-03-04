import 'package:redstonex/networks/exception/exception_handler.dart';
import 'package:redstonex/networks/exception/api_exception.dart';
import 'package:redstonex/utils/loading.dart';

class SyncRequester {
  static Future load(
    Function() block, {
    bool showLoading = true,
    String? loadingText,
    bool Function(ApiException)? onError,
  }) async {
    try {
      await XLoading().loading(
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

class ParallelRequester {
  static Future load(
    List<ParallelRequest> requestFutures, {
    bool showLoading = true,
    String? loadingText,
    bool Function(ApiException)? onError,
  }) async {
    List<Future<dynamic>> futures = requestFutures.map((e) => e.future).toList();

    try {
      await XLoading().loading(
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
