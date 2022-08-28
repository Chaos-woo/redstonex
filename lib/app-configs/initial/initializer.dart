
/// define singleton initializer.
abstract class Initializer {
  /// Initializer some singleton class into GetX container.
  ///
  /// ```dart
  ///   @override
  ///   void initial() => Get.put<S>(dependency, tag: tag);
  /// ```
  void init();
}