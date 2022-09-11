import 'package:redstonex/ioc-core/mirror-core/mirror_definiton.dart';
import 'package:reflectable/reflectable.dart';

/// Create instance by [MirrorDefinition]
abstract class WithoutMirrorDefinitionHolderFactory {
  dynamic newInstance(
    InstanceMirror instanceMirror,
    MethodMirror methodMirrorm, {
    String constructorName = '',
    List positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  });
}
