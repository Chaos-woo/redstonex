import 'package:redstonex/ioc-core/mirror-core/definitions/bean_definition_holder_factory.dart';
import 'package:redstonex/ioc-core/mirror-core/bean_definition.dart';

/// Holder mirror definition and named [_name] instance.
///
class BeanDefinitionHolder implements BeanDefinitionHolderFactory {
  final BeanDefinition _mirrorDefinition;
  final String? _name;

  /// Holds references to every registered Instance
  late final dynamic _instance;

  BeanDefinitionHolder(this._mirrorDefinition, this._name) {
    _instance = newInstance(_mirrorDefinition);
  }

  String? get name => _name;

  dynamic get instance => _instance;

  BeanDefinition get mirrorDefinition => _mirrorDefinition;

  @override
  dynamic newInstance(
    BeanDefinition mirrorDefinition, {
    String constructorName = '',
    List positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  }) {
    dynamic instance = mirrorDefinition.classMirror
        .newInstance(constructorName, positionalArguments, namedArguments);

    return instance;
  }

  @override
  String toString() {
    return 'MirrorDefinitionHolder{_mirrorDefinition: $_mirrorDefinition, _name: $_name, _instance: $_instance}';
  }
}
