import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:retrofit/retrofit.dart';

part 'http_client_example.g.dart';

@RestApi()
abstract class HttpClientExample {
  factory HttpClientExample(Dio dio, {String baseUrl}) = _HttpClientExample;

  @GET('www.baidu.com')
  Future<String> getBaidu();
}
