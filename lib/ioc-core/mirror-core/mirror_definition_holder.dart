import 'package:redstonex/ioc-core/mirror-core/definitions/mirror_definition_holder_factory.dart';
import 'package:redstonex/ioc-core/mirror-core/mirror_definiton.dart';

/// Holder mirror definition and named [_name] instance.
///
class MirrorDefinitionHolder implements MirrorDefinitionHolderFactory {
  final MirrorDefinition _mirrorDefinition;
  final String? _name;

  /// Holds references to every registered Instance
  late final dynamic _instance;

  MirrorDefinitionHolder(this._mirrorDefinition, this._name) {
    _instance = newInstance(_mirrorDefinition);
  }

  String? get name => _name;

  dynamic get instance => _instance;

  MirrorDefinition get mirrorDefinition => _mirrorDefinition;

  @override
  dynamic newInstance(
    MirrorDefinition mirrorDefinition, {
    String constructorName = '',
    List positionalArguments = const [],
    Map<Symbol, dynamic> namedArguments = const {},
  }) {
    dynamic instance = mirrorDefinition.classMirror
        .newInstance(constructorName, positionalArguments, namedArguments);

    return instance;
  }
}
