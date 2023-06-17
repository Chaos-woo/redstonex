import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../app-configs/global_config.dart';
import 'configs/http_option.dart';
import 'exception/api_exception.dart';
import 'response/api_response.dart';
import 'response/raw_data.dart';

typedef ApiExceptionThrowAgainCallback = bool Function(rApiException);

/// Dio组件封装的网络客户端
class rHttpClient {
  late Dio _dio;
  late rHttpOption _httpOption;

  rHttpClient(
    String baseUrl, {
    rHttpOption? httpOption,
    List<Interceptor>? interceptors,
  }) {
    rHttpOption optional = httpOption ?? rHttpOptionBuilder().build();
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

  rHttpOption get httpOption => _httpOption.immutable();

  Future<rRawData> fetchApi<T>(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ApiExceptionThrowAgainCallback? onError,
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
      var exception = rApiException.from(e);
      if (onError?.call(exception) == true) {
        // 判断异常处理器处理后是否需要继续向上抛出异常
        throw exception;
      }
      return rRawData()..value = null;
    }
  }

  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  /// 请求响应内容处理
  rRawData _handleResponse<T>(Response response) {
    if (response.statusCode == 200) {
      if (T is rRawData) {
        /// T类型为RawData时，不按照Rest处理，直接返回结果
        return rRawData()..value = response.data;
      } else {
        rApiResponse apiResponse = rApiResponse.fromJson(response.data);
        return rGlobalConfig.instance.globalHttpOptionConfigs.customBusinessResponseProcessor.call(apiResponse);
      }
    } else {
      var exception =
          rApiException(response.statusCode, rGlobalConfig.instance.globalHttpOptionConfigs.httpError.eDefault);
      throw exception;
    }
  }

  Future<rRawData> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
        ApiExceptionThrowAgainCallback? onError,
  }) {
    return fetchApi<T>(
      url,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      headers: headers,
      onError: onError,
    );
  }

  Future<rRawData> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
        ApiExceptionThrowAgainCallback? onError,
  }) {
    return fetchApi<T>(
      url,
      method: "POST",
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<rRawData> delete<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
        ApiExceptionThrowAgainCallback? onError,
  }) {
    return fetchApi<T>(
      url,
      method: "DELETE",
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<rRawData> put<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
        ApiExceptionThrowAgainCallback? onError,
  }) {
    return fetchApi<T>(
      url,
      method: "PUT",
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  Future<rRawData> patch<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
        ApiExceptionThrowAgainCallback? onError,
  }) {
    return fetchApi<T>(
      url,
      method: "PATCH",
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
      var exception = rApiException.fromDioError(e);
      throw exception;
    }
  }

  Stream<T> getStream<T>(String url, CancelToken cancelToken,
      {required bool Function(String data) validDataPredictor,
      required bool Function(String data) donePredictor,
      required String Function(String data) dataProcessor,
      required T Function(Map<String, dynamic>) onSuccess}) {
    final controller = StreamController<T>.broadcast();
    _dio.get(url, cancelToken: cancelToken, options: Options(responseType: ResponseType.stream)).then((it) {
      (it.data.stream as Stream).listen((it) {
        final rawData = utf8.decode(it);

        final dataList = rawData.split("\n").where((element) => element.isNotEmpty).toList();

        for (final data in dataList) {
          if (!validDataPredictor.call(data)) {
            continue;
          }
          if (!donePredictor.call(data)) {
            controller
              ..sink
              ..add(onSuccess(jsonDecode(dataProcessor.call(data))));
          } else {
            return;
          }
        }
      }, onDone: () {
        controller.close();
      }, onError: (err, t) {
        controller
          ..sink
          ..addError(err, t);
      });
    }, onError: (err, t) {
      controller
        ..sink
        ..addError(err, t);
    });

    return controller.stream;
  }

  Stream<T> sse<T>(
    String url,
    CancelToken cancelToken,
    Map<String, dynamic> request, {
    required bool Function(String data) validDataPredictor,
    required bool Function(String data) donePredictor,
    required String Function(String data) dataProcessor,
    required T Function(Map<String, dynamic> value) completeCallback,
  }) {
    final controller = StreamController<T>.broadcast();

    _dio
        .post(url,
            cancelToken: cancelToken, data: json.encode(request), options: Options(responseType: ResponseType.stream))
        .then((iterator) {
      iterator.data.stream.listen((it) {
        final raw = utf8.decode(it);
        final dataList = raw.split("\n").where((element) => element.isNotEmpty).toList();

        for (final data in dataList) {
          if (!validDataPredictor.call(data)) {
            continue;
          }

          if (!donePredictor.call(data)) {
            controller
              ..sink
              ..add(completeCallback(jsonDecode(dataProcessor.call(data))));
          } else {
            return;
          }
        }
      }, onDone: () {
        controller.close();
      }, onError: (error, t) {
        controller
          ..sink
          ..addError(error, t);
      });
    }, onError: (err, t) {
      controller
        ..sink
        ..addError(err, t);
    });
    return controller.stream;
  }
}
