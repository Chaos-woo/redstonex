import 'package:redstonex/ioc-core/bean-core/definitions/without_bean_definition_holder_factory.dart';
import 'package:reflectable/reflectable.dart';

/// Holder mirror definition and named [_name] instance.
///
class WithoutBeanDefinitionHolder implements WithoutMirrorDefinitionHolderFactory {
  final InstanceMirror _instanceMirror;
  final MethodMirror _methodMirror;
  final String? _name;

  /// Holds references to every registered Instance
  late final dynamic _instance;

  WithoutBeanDefinitionHolder(this._instanceMirror, this._methodMirror, this._name) {
    _instance = newInstance(_instanceMirror, _methodMirror);
  }

  String? get name => _name;

  dynamic get instance => _instance;

  @override
  dynamic newInstance(
    InstanceMirror instanceMirror,
    MethodMirror methodMirror, {
    String constructorName = '',
    List positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  }) {
    dynamic instance = instanceMirror.invoke(methodMirror.simpleName, positionalArguments, namedArguments);

    return instance;
  }

  @override
  String toString() {
    return 'WithoutMirrorDefinitionHolder{_instanceMirror: $_instanceMirror, _methodMirror: $_methodMirror, _name: $_name, _instance: $_instance}';
  }
}
