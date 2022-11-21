import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/app-configs/user-configs/global_http_option_configs.dart';
import 'package:redstonex/net/configs/http_option.dart';
import 'package:redstonex/net/exception/net_exception.dart';
import 'package:redstonex/net/response/api_response.dart';
import 'package:redstonex/net/response/raw_data.dart';

class RequestClient {
  late Dio _dio;
  late HttpOption _httpOption;

  RequestClient(
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

  Future<T?> request<T>(
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
    }

    return null;
  }

  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  Future<T?> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      queryParameters: queryParameters,
      headers: headers,
      onError: onError,
    );
  }

  Future<T?> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      method: "POST",
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<T?> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      method: "DELETE",
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<T?> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      method: "PUT",
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  ///请求响应内容处理
  T? _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      if (T.toString() == (RawData).toString()) {
        /// 不使用框架中的ApiResponse封装时，T使用RawData类型
        RawData raw = RawData();
        raw.value = response.data;
        return raw as T;
      } else {
        ApiResponse<T> apiResponse = ApiResponse<T>.fromJson(response.data);
        return _handleBusinessResponse<T>(apiResponse);
      }
    } else {
      var exception = ApiException(response.statusCode, ApiException.unknownException);
      throw exception;
    }
  }

  ///业务内容处理
  T? _handleBusinessResponse<T>(ApiResponse<T> response) {
    GlobalHttpOptionConfigs httpConfig = GlobalConfig.of().globalHttpOptionConfigs;
    if (response.code == httpConfig.businessSuccCode) {
      return response.data;
    } else {
      var exception = ApiException(response.code, response.message);
      throw exception;
    }
  }
}
