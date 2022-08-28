import 'package:get/get.dart';
import 'package:redstonex/app-configs/initial/initializer.dart';
import 'package:redstonex/app-configs/initial/singleton/built_in_singleton_initializer.dart';
import 'package:redstonex/app-configs/initial/singleton/singleton_initializer.dart';

/// A singleton initializer manager of classes.
///
/// Adding in singleton class initializer that you want to make singleton before
/// launching app.
///
/// These singleton classes recommend similar or business-related, invoking
/// [Initializer.initial] method to add. And [SingletonInitializerManager]
/// will invoking [initial] method to put them in GetX sinleton container.
///
/// Recommend singleton extends [GetxService], then GetX will not
/// dispose it when after using [GetBuilder], [GetView], etc.
///
/// ```dart
/// class InitializerManager extends AbstractSingletonInitializer {
///   @override
///   void initial() => ...
/// }
///
/// SingletonInitializerManager.register(InitializerManager());
/// SingletonInitializerManager.initial();
/// ```
///
class SingletonInitializerManager {
  /// singleton initializer of implementing [Initializer]
  static final List<SingletonInitializer> _initializers = [];

  /// statistics
  static final SingletonInitStatistics statistics = SingletonInitStatistics();

  /// Recommend [main] method firstly to call.
  static void init() {
    if (statistics.initial) {
      return;
    }

    _initializers.insert(0, BuiltInSingletonInitializer());

    statistics.initializerCount = _initializers.length;
    statistics.startTime = DateTime.now();
    for (Initializer initializer in _initializers) {
      initializer.init();
    }
    statistics.initial = true;
    statistics.endTime = DateTime.now();
  }

  /// Need call before [initial], or else someone(initializer) will invalid.
  static void register(SingletonInitializer initializer) {
    _initializers.add(initializer);
  }
}

/// A singleton Initial statistics information.
class SingletonInitStatistics {
  /// initial state
  bool initial = false;

  /// initializer count
  int initializerCount = 0;

  /// start initial time
  late DateTime startTime;

  /// end initial time
  late DateTime endTime;

  /// initial cost, millisecond
  int get initialCost =>
      endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;
}
