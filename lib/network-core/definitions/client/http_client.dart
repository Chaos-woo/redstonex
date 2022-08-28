import 'package:dio/dio.dart';

/// A http proxy of access data.
///
/// Use retrofit see also https://pub.dev/packages/retrofit.
/// And example test module retrofit-dio's [HttpClientExample]
/// class.
abstract class HttpClient {
  final Dio _dio;
  String? baseUrl;

  HttpClient(this._dio, {this.baseUrl});
}
