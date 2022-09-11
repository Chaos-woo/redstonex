import 'package:dartx/dartx.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:redstonex/commons/exceptions/no_such_mirror_definition_exception.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/registrable_ref.dart';
import 'package:redstonex/ioc-core/metadata-core/utils/metadata_util.dart';
import 'package:redstonex/ioc-core/mirror-core/mirror_definition_holder.dart';
import 'package:redstonex/ioc-core/mirror-core/mirror_definiton.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/metadata_mirror_util.dart';
import 'package:reflectable/reflectable.dart';

import 'metadata-core/reflection.dart';

/// Instance container following the application lifecycle.
///
/// reference: [GetInstance]、[GetInstance._InstanceBuilderFactory]
class ApplicationContainer {
  factory ApplicationContainer() => _container ??= const ApplicationContainer._();

  const ApplicationContainer._();

  static ApplicationContainer? _container;

  /// Holds references to every Instance type definition
  static final Map<Type, MirrorDefinition> _mirrorDefinitions = {};

  /// Holds references to every class when application
  /// initialize in `main` method
  static final Map<String, MirrorDefinitionHolder> _mirrorDefinitionHolders = {};

  /// Builtin definitions that must be registered.
  static final List<Type> _builtinDefinitions = [];
  static final List<Reflectable> _builtinReflectableMetadatas = [];

  /// start point.
  void initializeAppContainer(List<Type> builtinDefinitions, List<Reflectable> builtinReflectableMetadatas) {
    _builtinDefinitions.addAll(builtinDefinitions);
    _builtinReflectableMetadatas.addAll(builtinReflectableMetadatas);

    /// start parse
    Loggers.of().i('initialize application container start');

    _mirrorDefinitions.addAll(_parseAnnotatedBasicMirrors());
    _mirrorDefinitionHolders.addAll(_parseMirrorDefinitionHolders());

    /// end parse
    Loggers.of().i('initialize application container end');
  }

  /// Parse all pointed annotated class mirror definition.
  Map<Type, MirrorDefinition> _parseAnnotatedBasicMirrors() {
    Map<Type, MirrorDefinition> allDefinitions = {};

    for(Reflectable reflectableMetadata in _builtinReflectableMetadatas) {
      List<ClassMirror> classMirrors = MetadataMirrorUtil.annotatedClass(reflectableMetadata);
      Map<Type, MirrorDefinition> definitions = {};
      for (ClassMirror clazz in classMirrors) {
        definitions[clazz.runtimeType] = MirrorDefinition(clazz);
      }
      allDefinitions.addAll(definitions);
    }

    return allDefinitions;
  }

  /// Create [MirrorDefinitionHolder] instance by [MirrorDefinition] list
  Map<String, MirrorDefinitionHolder> _parseMirrorDefinitionHolders() {
    Map<String, MirrorDefinitionHolder> holders = {};

    for(Reflectable reflectableMetadata in _builtinReflectableMetadatas) {
      List<ClassMirror> classMirrors = MetadataMirrorUtil.annotatedClass(reflectableMetadata);
      if (reflectableMetadata is Reflection) {
        holders.addAll(_parseReflectionMetadata(classMirrors));
      } else if (reflectableMetadata is RefreshConfiguration) {
        holders.addAll(_parseReflectionConfigurationMetadata(classMirrors));
      }
    }

    return holders;
  }

  Map<String, MirrorDefinitionHolder> _parseReflectionMetadata(List<ClassMirror> classMirrors) {
    Map<String, MirrorDefinitionHolder> holders = {};

    for (ClassMirror classMirror in classMirrors) {
      MirrorDefinition? definition = _mirrorDefinitions[classMirror.runtimeType];
      if (definition == null) {
        continue;
      }

      List<Object> carriers = MetadataMirrorUtil.classAnnotationCarriers(classMirror);
      NamedRef? namedRef = MetadataUtil.findCarrier<NamedRef>(carriers);
      String? name = namedRef?.name;
      String key = _getKey(definition.actualType, name);
      holders[key] = MirrorDefinitionHolder(definition, name);
    }

    return holders;
  }

  Map<String, MirrorDefinitionHolder> _parseReflectionConfigurationMetadata(List<ClassMirror> classMirrors) {
    Map<String, MirrorDefinitionHolder> holders = {};

    // for (ClassMirror classMirror in classMirrors) {
    //   MirrorDefinition? definition = _mirrorDefinitions[classMirror.runtimeType];
    //   if (definition == null) {
    //     continue;
    //   }
    //
    //   List<Object> carriers = MetadataMirrorUtil.classAnnotationCarriers(classMirror);
    //   NamedRef? namedRef = MetadataUtil.findCarrier<NamedRef>(carriers);
    //   String? name = namedRef?.name;
    //   String key = _getKey(definition.actualType, name);
    //   holders[key] = MirrorDefinitionHolder(definition, name);
    // }

    return holders;
  }

  String _getKey(Type type, String? name) {
    String runtimeName = type.toString();
    return name.isNotNullOrBlank ? '{$runtimeName}_{$name}' : runtimeName;
  }

  S findInSelfContainer<S>({String? tag}) {
    String name = _getKey(S, tag);
    if (_mirrorDefinitionHolders[name] != null) {
      return _mirrorDefinitionHolders[name]!.instance as S;
    } else {
      throw NoSuchMirrorDefinitionException('not found mirror definition holder for type $S and name $tag');
    }
  }
}
