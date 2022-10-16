// ignore_for_file: prefer_collection_literals

import 'dart:collection';

import 'package:logger/logger.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/commons/log/redstone_logger.dart';
import 'package:redstonex/commons/standards/of_syntax.dart';

/// A log manager.
///
/// Manage all named [RedstoneLogger]. various logger will
/// stored it and classified by various dimensions
///
/// Add a [LogFilter] decide logger and listen log event.
///
/// Add a [LogOutput] that receiving [LogPrinter] stream and output
/// to any destination.
///
class Loggers with OfSyntax {
  /// fixed redstonex log name
  static const String _fixedRedstoneXLoggerName = '_fixedRedstoneXLogger';

  /// built-in logger
  static RedstoneLogger? _builtinLogger;

  /// log manager initial state
  static bool _builtInLoggerInitialState = false;

  /// built-in logger replace count
  static int _replaceCount = 0;

  /// named loggers
  static final Map<String, RedstoneLogger> _namedLoggers = {};

  /// loggers of classifying by level
  static final Map<Level, LinkedHashSet<RedstoneLogger>> _levelLoggers = {};

  /// Get a new logger and put it in map
  static RedstoneLogger newLogger(
    String name, {
    LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
    Level? lowestLevel,
  }) {
    RedstoneLogger logger = RedstoneLogger.newLogger(
      name,
      filter: filter,
      printer: printer,
      output: output,
      lowestLevel: lowestLevel,
    );
    _storageLoggerInMemory(logger);
    return logger;
  }

  /// Storage a logger in memory
  static void _storageLoggerInMemory(RedstoneLogger logger) {
    /// named map
    _namedLoggers[logger.name] = logger;

    /// level map
    Level level = logger.lowestLevel ?? GlobalConfig.of().globalLogConfigs.defLogLevel;
    LinkedHashSet<RedstoneLogger>? loggers = _levelLoggers[level];
    loggers ??= LinkedHashSet<RedstoneLogger>();
    loggers.add(logger);
    _levelLoggers[level] = loggers;
  }

  /// Get built-in logger
  static RedstoneLogger of() => builtInLogger();

  /// Get named logger.
  ///
  /// If name is null, will return built-in logger.
  /// If [_namedLoggers] can not get named logger, will
  /// create a logger with [name], otherwise return
  /// exist [_namedLoggers]'s named logger.
  ///
  /// If named [name] logger not exist [_namedLoggers],
  /// will create a new logger with [level] and storage in it.
  static RedstoneLogger ofNamed({String? name, Level? level}) {
    if (name == null) {
      return builtInLogger();
    } else {
      RedstoneLogger? logger = _namedLoggers[name];
      if (logger == null) {
        logger = _defLogger(name: name, level: level);
        _storageLoggerInMemory(logger);
      }
      return logger;
    }
  }

  /// Get built-in logger.
  ///
  /// Replace built-in logger for [replace] param
  static RedstoneLogger builtInLogger({bool replace = false}) {
    if (_builtinLogger == null) {
      _builtInLoggerInitialState = true;
      _builtinLogger = _defLogger(name: _fixedRedstoneXLoggerName, isBuiltinLog: true);
    } else if (_builtInLoggerInitialState && replace) {
      _builtinLogger = _defLogger(name: _fixedRedstoneXLoggerName, isBuiltinLog: true);
      _replaceCount++;
      _builtinLogger?.w('''Replace built-in logger at ${DateTime.now()}, 
          has replaced time is $_replaceCount, 
          built-in logger named $_fixedRedstoneXLoggerName.''');
    }

    return _builtinLogger!;
  }

  /// Default logger, external can not access
  static RedstoneLogger _defLogger(
          {required String name, Level? level, bool isBuiltinLog = false}) =>
      RedstoneLogger.newLogger(
        name,
        printer: RedstoneLogger.defPrettyPrinter(),
        lowestLevel: level ??
            (isBuiltinLog
                ? GlobalConfig.of().globalLogConfigs.defBuiltinLogLevel
                : GlobalConfig.of().globalLogConfigs.defLogLevel),
      );
}
