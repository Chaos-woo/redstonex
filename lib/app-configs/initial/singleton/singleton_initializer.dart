
import 'package:redstonex/app-configs/initial/initializer.dart';

/// define singleton initializer.
abstract class SingletonInitializer extends Initializer {
  @override
  void init() => initSingletons();

  /// Initializer some singleton class into GetX container.
  ///
  /// ```dart
  ///   @override
  ///   void initial() => Get.put<S>(dependency, tag: tag);
  /// ```
  void initSingletons();
}