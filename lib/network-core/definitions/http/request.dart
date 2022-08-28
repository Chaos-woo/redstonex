import 'package:dio/dio.dart';
import 'package:redstonex/network-core/definitions/http/http_method.dart';

/// A http request
class Request {
  dynamic data;
  HttpMethod method;
  RequestOptions requestOption;

  Request(
    this.requestOption, {
    this.data,
    this.method = HttpMethod.get,
  });
}
