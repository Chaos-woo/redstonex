import 'dart:async';

import 'package:flutter/material.dart';

import '../../resources/constant.dart';
import 'redstonex_default_app.dart';

typedef FlutterErrorReporter = void Function(FlutterErrorDetails details);

/// 应用初始化器
class rAppInitializer {
  /// 自定义异常上报器
  static FlutterErrorReporter? _errorReporter;

  static void run(
    Widget myApp, {
    Function()? preBuiltinInit,
    Function()? postBuiltinInit,
    FlutterErrorReporter? errorReporter,
  }) {
    _errorReporter = errorReporter;

    /// 捕获异常
    catchException(() => rDefaultApp.run(
          myApp,
          preBuiltinInit: preBuiltinInit,
          postBuiltinInit: postBuiltinInit,
        ));
  }

  ///异常捕获处理
  static void catchException<T>(T Function() callback) {
    /// 捕获异常的回调
    FlutterError.onError = (FlutterErrorDetails details) {
      if (!rConstant.inProduction) {
        /// 非生产环境，直接将异常信息打印。
        FlutterError.dumpErrorToConsole(details);
      } else {
        /// release时，将异常交由zone统一处理。
        Zone.current.handleUncaughtError(details.exception, details.stack!);
        _reportErrorLog(details);
      }
    };

    runZonedGuarded(() async {
      callback.call();
    }, (Object error, StackTrace stackTrace) async {
      var details = _makeDetails(error, stackTrace);
      _reportErrorLog(details);
    }, zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLogs(parent, zone, line);
      },
    ));
  }

  /// 日志拦截, 收集日志
  static void collectLogs(ZoneDelegate parent, Zone zone, String line) {
    parent.print(zone, "&ZoneGuarded: $line");
  }

  /// 上报错误和日志逻辑
  static void _reportErrorLog(FlutterErrorDetails details) {
    _errorReporter?.call(details);
  }

  /// 构建错误信息
  static FlutterErrorDetails _makeDetails(Object error, StackTrace stackTrace) {
    return FlutterErrorDetails(exception: error, stack: stackTrace);
  }
}
