import 'dart:convert';

import 'package:dio/dio.dart';

import '../app-configs/global_config.dart';
import 'configs/http_option.dart';
import 'exception/api_exception.dart';
import 'response/api_response.dart';
import 'response/raw_data.dart';

class HttpClient {
  late Dio _dio;
  late HttpOption _httpOption;

  HttpClient(
    String baseUrl, {
    HttpOption? httpOption,
    List<Interceptor>? interceptors,
  }) {
    HttpOption optional = httpOption ?? HttpOptionBuilder().build();
    _httpOption = optional;
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: optional.connectTimeout,
      receiveTimeout: optional.receiveTimeOut,
      sendTimeout: optional.sendTimeout,
      responseType: optional.responseType,
      contentType: optional.sendContentType,
    );
    _dio = Dio(options);

    /// http适配器设置
    if (optional.httpClientAdapter != null) {
      _dio.httpClientAdapter = optional.httpClientAdapter!;
    }

    /// 解码
    _dio.transformer = DefaultTransformer()..jsonDecodeCallback = optional.jsonDecodeCallback;

    _dio.interceptors.addAll(interceptors ?? const []);
  }

  HttpOption get httpOption => _httpOption.immutable();

  Future<RawData> fetchApi<T>(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool Function(ApiException)? onError,
  }) async {
    try {
      Options options = Options()
        ..method = method
        ..headers = headers;

      data = _convertRequestData(data);

      Response response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );

      return _handleResponse<T>(response);
    } catch (e) {
      var exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        throw exception;
      }
      return RawData()..value = null;
    }
  }

  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  Future<RawData> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      headers: headers,
      onError: onError,
    );
  }

  Future<RawData> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
      method: "POST",
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<RawData> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
      method: "DELETE",
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<RawData> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
      method: "PUT",
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  /// 下载
  Future download(
    String uri,
    String savePath, {
    ProgressCallback? progressCallback,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) async {
    try {
      await _dio.download(
        uri,
        savePath,
        onReceiveProgress: progressCallback,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        data: data,
        options: options,
      );
    } on DioError catch (e) {
      var exception = ApiException.fromDioError(e);
      throw exception;
    }
  }

  /// 请求响应内容处理
  RawData _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      if (T is RawData) {
        /// T类型为RawData时，不按照Rest处理，直接返回结果
        return RawData()..value = response.data;
      } else {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        return GlobalConfig.instance.globalHttpOptionConfigs.customBusinessResponseProcessor
            .call(apiResponse);
      }
    } else {
      var exception = ApiException(
          response.statusCode, GlobalConfig.instance.globalHttpOptionConfigs.httpError.eDefault);
      throw exception;
    }
  }
}
