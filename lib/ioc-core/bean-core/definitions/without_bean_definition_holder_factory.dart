import 'package:redstonex/ioc-core/bean-core/bean_definition.dart';
import 'package:reflectable/reflectable.dart';

/// Create instance by [BeanDefinition]
abstract class WithoutMirrorDefinitionHolderFactory {
  dynamic newInstance(
    InstanceMirror instanceMirror,
    MethodMirror methodMirror, {
    String constructorName = '',
    List positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  });
}
