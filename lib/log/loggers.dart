import 'package:dartx/dartx.dart';
import 'package:logger/logger.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/log/redstone_logger.dart';
import 'package:redstonex/std-core/of_syntax.dart';

/// A log manager.
///
/// Manage all named [RSLogger]. various logger will
/// stored it and classified by various dimensions
///
/// Add a [LogFilter] decide logger and listen log event.
///
/// Add a [LogOutput] that receiving [LogPrinter] stream and output
/// to any destination.
///
class Loggers with OfSyntax {
  /// fixed redstonex log name
  static const String _fixedRsLoggerName = '_fixedRSLogger';

  /// built-in logger
  static RSLogger? _builtinLogger;

  /// log manager initial state
  static bool _builtinLoggerInitialState = false;

  /// named loggers
  static final Map<String, RSLogger> _namedLoggers = {};

  /// Get a new logger and put it in map
  static RSLogger newLogger(
    String name, {
    LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
    Level? lowestLevel,
  }) {
    RSLogger logger = RSLogger.newLogger(
      name,
      filter: filter,
      printer: printer,
      output: output,
      lowestLevel: lowestLevel,
    );
    _saveLogger2Container(logger);
    return logger;
  }

  /// Storage a logger in memory
  static void _saveLogger2Container(RSLogger logger) {
    /// named map
    _namedLoggers[logger.name] = logger;
  }

  /// Get builtin logger
  static RSLogger of() => _getBuiltinLogger();

  /// Get named logger.
  ///
  /// If name is null, will return built-in logger.
  /// If [_namedLoggers] can not get named logger, will
  /// create a logger with [name], otherwise return
  /// exist [_namedLoggers]'s named logger.
  ///
  /// If named [name] logger not exist [_namedLoggers],
  /// will create a new logger with [level] and storage in it.
  static RSLogger ofNamed({String? name, Level? level}) {
    if (name.isNullOrBlank) {
      return _getBuiltinLogger();
    } else {
      RSLogger? logger = _namedLoggers[name];
      if (logger == null) {
        logger = _newLogger(name: name!, level: level);
        _saveLogger2Container(logger);
      }
      return logger;
    }
  }

  /// Get builtin logger.
  static RSLogger _getBuiltinLogger() {
    if (_builtinLoggerInitialState && _builtinLogger != null) {
      return _builtinLogger!;
    } else {
      _builtinLoggerInitialState = true;
      _builtinLogger = _newLogger(name: _fixedRsLoggerName, isBuiltinLog: true);
      return _builtinLogger!;
    }
  }

  /// Default logger, external can not access
  static RSLogger _newLogger({required String name, Level? level, bool isBuiltinLog = false}) => RSLogger.newLogger(
        name,
        printer: RSLogger.prettyPrinter(colors: !isBuiltinLog),
        lowestLevel: level ?? (isBuiltinLog ? Level.info : GlobalConfig.of().globalLogConfigs.defLogLevel),
      );
}
