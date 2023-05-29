import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../extension/string_extension.dart';

class rHttpClientAdapterBuilder {
  static HttpClientAdapter clientAdapter({String? proxy}) {
    return DefaultHttpClientAdapter()
      ..onHttpClientCreate = (client) {
        if (!proxy.oNullOrBlank) {
          client.findProxy = (url) => 'PROXY $proxy';
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
          return client;
        } else {
          return client;
        }
      };
  }
}
