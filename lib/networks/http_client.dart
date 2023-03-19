import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';
import 'package:redstonex/networks/configs/http_option.dart';
import 'package:redstonex/networks/exception/api_exception.dart';
import 'package:redstonex/networks/response/api_response.dart';
import 'package:redstonex/networks/response/raw_data.dart';

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
    _dio.interceptors.addAll(interceptors ?? const []);
  }

  HttpOption get httpOption => _httpOption.immutable();

  Future<RawData> fetchApi<T>(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
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
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
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
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
      method: "POST",
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
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
      method: "DELETE",
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
    bool Function(ApiException)? onError,
  }) {
    return fetchApi(
      url,
      method: "PUT",
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future download(String uri, String localPath, {ProgressCallback? progressCallback}) async {
    try {
      await _dio.download(
        uri,
        localPath,
        onReceiveProgress: progressCallback,
      );
    } on DioError catch (e) {
      var exception = ApiException.fromDioError(e);
      throw exception;
    }
  }

  ///请求响应内容处理
  RawData _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      if (T is RawData) {
        /// T类型为RawData时，不按照Rest处理，直接返回结果
        return RawData()..value = response.data;
      } else {
        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        return _handleBusinessResponse(apiResponse);
      }
    } else {
      var exception = ApiException(response.statusCode, ApiException.unknownException);
      throw exception;
    }
  }

  ///业务内容处理
  RawData _handleBusinessResponse(ApiResponse response) {
    GlobalHttpOptionConfigs httpConfig = GlobalConfig.of().globalHttpOptionConfigs;
    if (response.code == httpConfig.businessSuccessCode) {
      return response.data;
    } else {
      var exception = ApiException(response.code, response.message);
      throw exception;
    }
  }
}
