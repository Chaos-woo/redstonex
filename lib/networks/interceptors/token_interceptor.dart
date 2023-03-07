// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flustars_flutter3/flustars_flutter3.dart';
// import 'package:redstonex/net/configs/http_constant.dart';
// import 'package:redstonex/net/error_handle.dart';
// import 'package:redstonex/utils/rsxlog.dart';
// import 'package:redstonex/utils/other_utils.dart';
//
// class TokenInterceptor extends QueuedInterceptor {
//   Dio? _tokenDio;
//
//   Future<String?> getToken() async {
//     final Map<String, String> params = <String, String>{};
//     params['refresh_token'] = SpUtil.getString(HttpConstant.refreshToken).nullSafe;
//     try {
//       _tokenDio ??= Dio();
//       // _tokenDio!.options = DioUtils.instance.dio.options;
//       final Response<dynamic> response = await _tokenDio!.post<dynamic>('lgn/refreshToken', data: params);
//       if (response.statusCode == ExceptionHandle.success) {
//         return (json.decode(response.data.toString()) as Map<String, dynamic>)['access_token'] as String;
//       }
//     } catch (e) {
//       Logs.e('刷新Token失败！');
//     }
//     return null;
//   }
//
//   @override
//   Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
//     //401代表token过期
//     if (response.statusCode == ExceptionHandle.unauthorized) {
//       Logs.d('-----------自动刷新Token------------');
//       final String? accessToken = await getToken(); // 获取新的accessToken
//       Logs.e('-----------NewToken: $accessToken ------------');
//       SpUtil.putString(HttpConstant.accessToken, accessToken.nullSafe);
//
//       if (accessToken != null) {
//         // 重新请求失败接口
//         final RequestOptions request = response.requestOptions;
//         request.headers['Authorization'] = 'Bearer $accessToken';
//
//         final Options options = Options(
//           headers: request.headers,
//           method: request.method,
//         );
//
//         try {
//           Logs.e('----------- 重新请求接口 ------------');
//
//           /// 避免重复执行拦截器，使用tokenDio
//           final Response<dynamic> response = await _tokenDio!.request<dynamic>(
//             request.path,
//             data: request.data,
//             queryParameters: request.queryParameters,
//             cancelToken: request.cancelToken,
//             options: options,
//             onReceiveProgress: request.onReceiveProgress,
//           );
//           return handler.next(response);
//         } on DioError catch (e) {
//           return handler.reject(e);
//         }
//       }
//     }
//     super.onResponse(response, handler);
//   }
// }
