import 'package:logger/logger.dart';

/// An encapsulated logger
///
class RedStoneLogger {
  /// name of logger for search it
  final String name;

  /// unique and important logger
  final Logger _logger;

  /// see also [Logger]
  ///
  /// it not only filter log and can listen log event
  LogFilter? filter;

  /// see also [Logger]
  ///
  /// recommend using default
  LogPrinter? printer;

  /// see also [Logger]
  ///
  /// it not only filter log and can listen output event
  LogOutput? output;

  /// see also [Logger]
  Level? lowestLevel;

  /// Log a message at level [Level.verbose] of [_logger] proxy.
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.v(message, error, stackTrace);

  /// Log a message at level [Level.debug] of [_logger] proxy.
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  /// Log a message at level [Level.info] of [_logger] proxy.
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  /// Log a message at level [Level.warning] of [_logger] proxy.
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);

  /// Log a message at level [Level.error] of [_logger] proxy.
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  /// Log a message at level [Level.wtf] of [_logger] proxy.
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.wtf(message, error, stackTrace);

  /// Get a new logger of custom options
  /// of default options
  RedStoneLogger.newLogger(
    this.name, {
    this.filter,
    this.printer,
    this.output,
    this.lowestLevel,
  }) : _logger = Logger(
          filter: filter,
          printer: printer,
          output: output,
          level: lowestLevel,
        );

  /// Default pretty printer of frame.
  ///
  /// [methodCount]:number of method calls to be displayed
  /// [errorMethodCount]:number of method calls if stacktrace is provided
  /// [lineLength]:width of the output
  /// [colors]:Colorful log messages
  /// [printEmojis]:Print an emoji for each log message
  /// [printTime]:Should each log print contain a timestamp
  ///
  static PrettyPrinter defPrettyPrinter({
    int methodCount = 2,
    int errorMethodCount = 8,
    int lineLength = 120,
    bool colors = true,
    bool printEmojis = true,
    bool printTime = false,
  }) =>
      PrettyPrinter(
          methodCount: methodCount,
          errorMethodCount: errorMethodCount,
          lineLength: lineLength,
          colors: colors,
          printEmojis: printEmojis,
          printTime: printTime);
}
