import 'package:dio/dio.dart';
import 'package:redstonex/commons/exceptions/app_exception.dart';
import 'package:redstonex/network-core/definitions/http/request.dart';

/// Http request context.
///
class RequestContext {
  /// name of [RequestContext] for every request extra data
  static const String fixedExtraRequestCtxName = '_fixedExtraRequestCtxName';

  /// current request unique identifier
  String identifier;

  /// current request content
  Request request;

  /// current response content
  Response? response;

  /// timestamp at created
  int timestamp;

  /// log converted app exception [AppException]
  AppException? appException;

  RequestContext(this.identifier, this.request)
      : timestamp = DateTime.now().millisecondsSinceEpoch;
}
