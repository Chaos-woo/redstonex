import 'package:dartx/dartx.dart';
import 'package:redstonex/commons/exceptions/no_such_mirror_definition_exception.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/commons/log/rs_log.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/after_properties_set.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/autowired.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/named_reference.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/post_construct.dart';
import 'package:redstonex/ioc-core/metadata-core/components_configuration.dart';
import 'package:redstonex/ioc-core/metadata-core/utils/metadata_utils.dart';
import 'package:redstonex/ioc-core/mirror-core/mirror_definition_holder.dart';
import 'package:redstonex/ioc-core/mirror-core/mirror_definiton.dart';
import 'package:redstonex/ioc-core/mirror-core/without_mirror_definition_holder.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/metadata_mirror_utils.dart';
import 'package:reflectable/reflectable.dart';

import 'metadata-core/component.dart';

/// Instance container following the application lifecycle.
///
/// reference: [GetInstance]、[GetInstance._InstanceBuilderFactory]
class ApplicationContainer {
  factory ApplicationContainer() => _container ??= const ApplicationContainer._();

  const ApplicationContainer._();

  static ApplicationContainer? _container;

  /// Holds references to every Instance type definition.
  static final Map<Type, MirrorDefinition> _mirrorDefinitions = {};

  /// Holds references to every class when application
  /// initialize in `main` method.
  static final Map<String, MirrorDefinitionHolder> _mirrorDefinitionHolders = {};

  /// Holds references to reflection configuration's method
  /// class instance without [MirrorDefinition].
  ///
  /// Note that level 2 cache.
  static final Map<String, WithoutMirrorDefinitionHolder> _withoutMirrorDefinitionHolders = {};

  /// Builtin definitions that must be registered high priority.
  static final List<Type> _builtinDefinitions = [];

  /// Builtin reflectable metadata.
  static final List<Reflectable> _builtinReflectableMetadatas = [];

  static final RsLogger _logger = Loggers.of();

  /// Start point.
  void initializeAppContainer(List<Type> builtinDefinitions, List<Reflectable> builtinReflectableMetadatas) {
    _builtinDefinitions.addAll(builtinDefinitions);
    _builtinReflectableMetadatas.addAll(builtinReflectableMetadatas);

    /// start parse
    _logger.i('Initialize application container start');

    /// parse and save mirror definition
    _mirrorDefinitions.addAll(_doParseReflectionMirrorDefinitions());
    _magicApplicationContainerInitializeLog(_mirrorDefinitions);

    /// process instance configuration class firstly
    _withoutMirrorDefinitionHolders.addAll(_parseWithoutMirrorDefinitionHolders());
    _magicApplicationContainerInitializeLog(_withoutMirrorDefinitionHolders);

    /// process mirror definition instance class and dependency injection
    _mirrorDefinitionHolders.addAll(_doCreateMirrorDefinitionHolders());
    _magicApplicationContainerInitializeLog(_mirrorDefinitionHolders);

    /// process circular dependency injection
    _doCircularDependencyInjection();
    _magicApplicationContainerInitializeLog(_mirrorDefinitionHolders, afterCircularDependencyInjection: true);

    /// after dependency injection
    _doProcessInstanceAfterPropertiesSet(_mirrorDefinitionHolders.values.toList());

    /// end parse
    _logger.i('Initialize application container end');
  }

  /// Parse all pointed annotated class mirror definition.
  Map<Type, MirrorDefinition> _doParseReflectionMirrorDefinitions() {
    Map<Type, MirrorDefinition> allDefinitions = {};

    for (Reflectable reflectableMetadata in _builtinReflectableMetadatas) {
      List<ClassMirror> classMirrors = MetadataMirrorUtil.annotatedClass(reflectableMetadata);
      Map<Type, MirrorDefinition> definitions = {};
      for (ClassMirror clazz in classMirrors) {
        definitions[clazz.dynamicReflectedType] = MirrorDefinition(clazz);
      }
      allDefinitions.addAll(definitions);
    }

    return allDefinitions;
  }

  /// Create [MirrorDefinitionHolder] instance by [MirrorDefinition] list
  Map<String, MirrorDefinitionHolder> _doCreateMirrorDefinitionHolders() {
    Map<String, MirrorDefinitionHolder> holders = {};

    for (Reflectable reflectableMetadata in _builtinReflectableMetadatas) {
      List<ClassMirror> classMirrors = MetadataMirrorUtil.annotatedClass(reflectableMetadata);
      if (reflectableMetadata is Component) {
        holders.addAll(_doParseReflection(classMirrors));
      }
    }

    return holders;
  }

  /// Create [WithoutMirrorDefinitionHolder] instance
  Map<String, WithoutMirrorDefinitionHolder> _parseWithoutMirrorDefinitionHolders() {
    Map<String, WithoutMirrorDefinitionHolder> holders = {};

    for (Reflectable reflectableMetadata in _builtinReflectableMetadatas) {
      List<ClassMirror> classMirrors = MetadataMirrorUtil.annotatedClass(reflectableMetadata);
      if (reflectableMetadata is ComponentsConfiguration) {
        holders.addAll(_doParseReflectionConfiguration(classMirrors));
      }
    }

    return holders;
  }

  /// Inject dependency to application by parsing `MirrorDefinition`.
  Map<String, MirrorDefinitionHolder> _doParseReflection(List<ClassMirror> classMirrors) {
    Map<String, MirrorDefinitionHolder> holders = {};

    for (ClassMirror classMirror in classMirrors) {
      MirrorDefinition? definition = _mirrorDefinitions[classMirror.dynamicReflectedType];
      if (definition == null) {
        continue;
      }

      List<Object> carriers = MetadataMirrorUtil.classMetadataCarriers(classMirror);
      NamedReference? namedRef = MetadataUtil.findCarrier<NamedReference>(carriers);
      String? name = namedRef?.name;
      String key = _getKey(definition.actualType, name);
      MirrorDefinitionHolder mirrorDefinitionHolder = MirrorDefinitionHolder(definition, name);

      if (mirrorDefinitionHolder.instance != null && definition.instanceMemberMethodMirrors.isNotEmpty) {
        /// process instance @PostConstruct marked method
        List<MethodMirror> methodMirrors = definition.instanceMemberMethodMirrors;
        InstanceMirror instanceMirror = const Component().reflect(mirrorDefinitionHolder.instance);
        for (MethodMirror methodMirror in methodMirrors) {
          Object? keyCarrier = MetadataMirrorUtil.declarationAnyMetadata<PostConstruct>(methodMirror);
          if (keyCarrier == null) {
            continue;
          }
          instanceMirror.invoke(methodMirror.simpleName, []);

          /// only invoke first marked method
          break;
        }
      }

      holders[key] = mirrorDefinitionHolder;
    }

    return holders;
  }

  /// Parse dependency configuration. It cannot process `ClassMirror` definition.
  /// Only can auto inject dependency to application container.
  Map<String, WithoutMirrorDefinitionHolder> _doParseReflectionConfiguration(List<ClassMirror> classMirrors) {
    Map<String, WithoutMirrorDefinitionHolder> holders = {};

    for (ClassMirror classMirror in classMirrors) {
      MirrorDefinition? definition = _mirrorDefinitions[classMirror.dynamicReflectedType];
      if (definition == null) {
        continue;
      }

      List<MethodMirror> methodMirrors = definition.instanceMemberMethodMirrors;
      dynamic dynamicInstance = definition.classMirror.newInstance('', []);
      InstanceMirror instanceMirror = const ComponentsConfiguration().reflect(dynamicInstance);

      for (MethodMirror methodMirror in methodMirrors) {
        Object? keyCarrier = MetadataMirrorUtil.declarationReflectableMetadata<Component>(methodMirror);
        if (keyCarrier == null) {
          continue;
        }

        NamedReference? namedRef = MetadataUtil.findCarrier<NamedReference>(methodMirror.metadata);
        String? name = namedRef?.name;
        Object? returnInstance = instanceMirror.invoke(methodMirror.simpleName, []);
        if (returnInstance == null) {
          continue;
        }

        String key = _getKey(returnInstance.runtimeType, name);
        holders[key] = WithoutMirrorDefinitionHolder(instanceMirror, methodMirror, name);
      }
    }

    return holders;
  }

  static String _getKey(Type type, String? name) {
    String runtimeName = type.toString();
    return name.isNotNullOrBlank ? '${runtimeName}_$name' : runtimeName;
  }

  /// Inject properties that [_mirrorDefinitionHolders] and
  /// [_withoutMirrorDefinitionHolders] dependency
  static void _doCircularDependencyInjection() {
    for (MirrorDefinitionHolder holder in _mirrorDefinitionHolders.values) {
      Map<String, VariableMirror> variableMirrors = holder.mirrorDefinition.variableFieldMirrors;
      for (var entry in variableMirrors.entries) {
        String fieldName = entry.key;
        VariableMirror variableMirror = entry.value;
        List<Object> carriers = variableMirror.metadata;

        Autowired? autowiredCarrier = MetadataUtil.findCarrier<Autowired>(carriers);
        if (autowiredCarrier == null) {
          continue;
        }

        String? tag = autowiredCarrier.name;
        dynamic dependency = findDependencyByCarrierName(variableMirror.dynamicReflectedType, tag);

        if (dependency == null) {
          throw NoSuchMirrorDefinitionException(
              'not found mirror definition holder for dependency $fieldName and name ${autowiredCarrier.name}');
        }

        var instanceMirror = const Component().reflect(holder.instance);
        instanceMirror.invokeSetter(autowiredCarrier.setterName ?? fieldName, dependency);
      }
    }
  }

  /// Find dependency from application container.
  /// Note that it will return null.
  static dynamic findDependencyByCarrierName(Type type, String? tag) {
    String name = _getKey(type, tag);
    if (_mirrorDefinitionHolders[name] != null) {
      return _mirrorDefinitionHolders[name]!.instance;
    } else if (_withoutMirrorDefinitionHolders[name] != null) {
      return _withoutMirrorDefinitionHolders[name]!.instance;
    } else {
      return null;
    }
  }

  /// Whether exist dependency in application container
  static bool existDependency<S>({String? tag}) {
    return findDependencyByCarrierName(S, tag);
  }

  /// Find dependency in application container
  S findInSelfContainer<S>({String? tag}) {
    String name = _getKey(S, tag);
    if (_mirrorDefinitionHolders[name] != null) {
      return _mirrorDefinitionHolders[name]!.instance as S;
    } else if (_withoutMirrorDefinitionHolders[name] != null) {
      return _withoutMirrorDefinitionHolders[name]!.instance as S;
    } else {
      throw NoSuchMirrorDefinitionException('not found mirror definition holder for type $S and name $tag');
    }
  }

  /// Process instance's @AfterPropertiesSet marked member method
  void _doProcessInstanceAfterPropertiesSet(List<MirrorDefinitionHolder> mirrorDefinitionHolders) {
    for (MirrorDefinitionHolder mirrorDefinitionHolder in mirrorDefinitionHolders) {
      /// process instance @AfterPropertiesSet marked method
      if (mirrorDefinitionHolder.instance != null &&
          mirrorDefinitionHolder.mirrorDefinition.instanceMemberMethodMirrors.isNotEmpty) {
        List<MethodMirror> methodMirrors = mirrorDefinitionHolder.mirrorDefinition.instanceMemberMethodMirrors;
        InstanceMirror instanceMirror = const Component().reflect(mirrorDefinitionHolder.instance);
        for (MethodMirror methodMirror in methodMirrors) {
          Object? keyCarrier = MetadataMirrorUtil.declarationAnyMetadata<AfterPropertiesSet>(methodMirror);
          if (keyCarrier == null) {
            continue;
          }
          instanceMirror.invoke(methodMirror.simpleName, []);

          /// only invoke first marked method
          break;
        }
      }
    }
  }

  /// Collect applicationContainer initialize logs
  void _magicApplicationContainerInitializeLog(dynamic data, {bool afterCircularDependencyInjection = false}) {
    if (data is Map<Type, MirrorDefinition>) {
      _logger.i('MirrorDefinitions collect start');
      for(var entry in data.entries) {
        _logger.i('Type=${entry.key}, MirrorDefinition=${entry.value.toString()}');
      }
      _logger.i('MirrorDefinitions collect end');
    } else if (data is Map<String, MirrorDefinitionHolder>) {
      _logger.i('MirrorDefinitionHolders collect start, current is afterCircularDependencyInjection?: $afterCircularDependencyInjection');
      for(var entry in data.entries) {
        _logger.i('HolderName=${entry.key}, MirrorDefinitionHolder=${entry.value.toString()}');
      }
      _logger.i('MirrorDefinitionHolders collect end');
    } else if (data is Map<String, WithoutMirrorDefinitionHolder>) {
      _logger.i('WithoutMirrorDefinitionHolders collect start');
      for(var entry in data.entries) {
        _logger.i('HolderName=${entry.key}, WithoutMirrorDefinitionHolder=${entry.value.toString()}');
      }
      _logger.i('WithoutMirrorDefinitionHolders collect end');
    }
  }
}
