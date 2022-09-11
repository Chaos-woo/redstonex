import 'package:redstonex/ioc-core/mirror-core/definitions/without_mirror_definition_holder_factory.dart';
import 'package:reflectable/reflectable.dart';

/// Holder mirror definition and named [_name] instance.
///
class WithoutMirrorDefinitionHolder implements WithoutMirrorDefinitionHolderFactory {
  final InstanceMirror _instanceMirror;
  final MethodMirror _methodMirror;
  final String? _name;

  /// Holds references to every registered Instance
  late final dynamic _instance;

  WithoutMirrorDefinitionHolder(this._instanceMirror, this._methodMirror, this._name) {
    _instance = newInstance(_instanceMirror, _methodMirror);
  }

  String? get name => _name;

  dynamic get instance => _instance;

  @override
  dynamic newInstance(
    InstanceMirror instanceMirror,
    MethodMirror methodMirrorm, {
    String constructorName = '',
    List positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  }) {
    dynamic instance = instanceMirror.invoke(methodMirrorm.simpleName, positionalArguments, namedArguments);

    return instance;
  }
}
