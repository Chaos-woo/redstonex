import 'package:redstonex/app-configs/initial/initializer.dart';
import 'package:redstonex/commons/log/loggers.dart';

/// BuiltIn logger initializer.
class BuiltInLoggerInitializer extends Initializer {
  @override
  void init() async {
    /// initial built-in logger
    Loggers.builtInLogger();
  }
}
