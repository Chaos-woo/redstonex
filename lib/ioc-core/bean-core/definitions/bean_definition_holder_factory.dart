import 'package:redstonex/ioc-core/bean-core/bean_definition.dart';

/// Create instance by [BeanDefinition]
abstract class BeanDefinitionHolderFactory {
  dynamic newInstance(
    BeanDefinition definition, {
    String constructorName = '',
    List positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  });
}
