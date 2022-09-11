import 'package:redstonex/ioc-core/mirror-core/mirror_definiton.dart';

/// Create instance by [MirrorDefinition]
abstract class MirrorDefinitionHolderFactory {
  dynamic newInstance(MirrorDefinition mirrorDefinition,
      {String constructorName = '',
      List positionalArguments = const [],
      Map<Symbol, dynamic> namedArguments = const {}});
}
