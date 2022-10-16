import 'package:dio/dio.dart';
import 'package:redstonex/events-core/events_bus.dart';
import 'package:redstonex/network-core/definitions/events/built_in_loading_event.dart';

/// Http request interceptor for loading.
///
/// It will publish a loading event for request and response.
/// Subscribe [BuiltinLoadingEvent] and judge event type [BuiltinLoadingEventType] to
/// show loading widget.
class RequestLoadingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    EventsBus.fireZeroDelay(BuiltinLoadingEvent(BuiltinLoadingEventType.request));
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    EventsBus.fireZeroDelay(BuiltinLoadingEvent(BuiltinLoadingEventType.error));
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    EventsBus.fireZeroDelay(BuiltinLoadingEvent(BuiltinLoadingEventType.ok));
    handler.next(response);
  }
}
