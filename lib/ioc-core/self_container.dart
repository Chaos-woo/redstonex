import 'package:dartx/dartx.dart';
import 'package:redstonex/commons/exceptions/no_such_mirror_definition_exception.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/commons/log/redstone_logger.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/after_properties_set.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/autowired.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/named_reference.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/post_construct.dart';
import 'package:redstonex/ioc-core/metadata-core/components_configuration.dart';
import 'package:redstonex/ioc-core/metadata-core/utils/metadata_utils.dart';
import 'package:redstonex/ioc-core/bean-core/bean_definition_holder.dart';
import 'package:redstonex/ioc-core/bean-core/bean_definition.dart';
import 'package:redstonex/ioc-core/bean-core/without_bean_definition_holder.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/metadata_mirror_utils.dart';
import 'package:reflectable/reflectable.dart';

import 'metadata-core/component.dart';

/// Instance container following the application lifecycle.
///
/// reference: [GetInstance]、[GetInstance._InstanceBuilderFactory]
class SelfContainer {
  factory SelfContainer() => _container ??= const SelfContainer._();

  const SelfContainer._();

  static SelfContainer? _container;

  /// Holds references to every Instance type definition.
  static final Map<Type, BeanDefinition> _mirrorDefinitions = {};

  /// Holds references to every class when application
  /// initialize in `main` method.
  static final Map<String, BeanDefinitionHolder> _mirrorDefinitionHolders = {};

  /// Holds references to reflection configuration's method
  /// class instance without [BeanDefinition].
  ///
  /// Note that level 2 cache.
  static final Map<String, WithoutBeanDefinitionHolder> _withoutMirrorDefinitionHolders = {};

  /// Builtin definitions that must be registered high priority.
  static final List<Type> _builtinDefinitions = [];

  /// Builtin reflectable metadata.
  static final List<Reflectable> _builtinReflectableMetadataList = [];

  static final RedstoneLogger _logger = Loggers.of();

  /// Start point.
  void initializeAppContainer(List<Type> builtinDefinitions, List<Reflectable> builtinReflectableMetadatas) {
    _builtinDefinitions.addAll(builtinDefinitions);
    _builtinReflectableMetadataList.addAll(builtinReflectableMetadatas);

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
  Map<Type, BeanDefinition> _doParseReflectionMirrorDefinitions() {
    Map<Type, BeanDefinition> allDefinitions = {};

    for (Reflectable reflectableMetadata in _builtinReflectableMetadataList) {
      List<ClassMirror> classMirrors = MetadataBeanUtils.annotatedClass(reflectableMetadata);
      Map<Type, BeanDefinition> definitions = {};
      for (ClassMirror clazz in classMirrors) {
        definitions[clazz.dynamicReflectedType] = BeanDefinition(clazz);
      }
      allDefinitions.addAll(definitions);
    }

    return allDefinitions;
  }

  /// Create [BeanDefinitionHolder] instance by [BeanDefinition] list
  Map<String, BeanDefinitionHolder> _doCreateMirrorDefinitionHolders() {
    Map<String, BeanDefinitionHolder> holders = {};

    for (Reflectable reflectableMetadata in _builtinReflectableMetadataList) {
      List<ClassMirror> classMirrors = MetadataBeanUtils.annotatedClass(reflectableMetadata);
      if (reflectableMetadata is Component) {
        holders.addAll(_doParseReflection(classMirrors));
      }
    }

    return holders;
  }

  /// Create [WithoutBeanDefinitionHolder] instance
  Map<String, WithoutBeanDefinitionHolder> _parseWithoutMirrorDefinitionHolders() {
    Map<String, WithoutBeanDefinitionHolder> holders = {};

    for (Reflectable reflectableMetadata in _builtinReflectableMetadataList) {
      List<ClassMirror> classMirrors = MetadataBeanUtils.annotatedClass(reflectableMetadata);
      if (reflectableMetadata is ComponentsConfiguration) {
        holders.addAll(_doParseReflectionConfiguration(classMirrors));
      }
    }

    return holders;
  }

  /// Inject dependency to application by parsing `MirrorDefinition`.
  Map<String, BeanDefinitionHolder> _doParseReflection(List<ClassMirror> classMirrors) {
    Map<String, BeanDefinitionHolder> holders = {};

    for (ClassMirror classMirror in classMirrors) {
      BeanDefinition? definition = _mirrorDefinitions[classMirror.dynamicReflectedType];
      if (definition == null) {
        continue;
      }

      List<Object> carriers = MetadataBeanUtils.classMetadataCarriers(classMirror);
      NamedReference? namedRef = MetadataUtils.findMetadata<NamedReference>(carriers);
      String? name = namedRef?.name;
      String key = _getKey(definition.actualType, name);
      BeanDefinitionHolder mirrorDefinitionHolder = BeanDefinitionHolder(definition, name);

      if (mirrorDefinitionHolder.instance != null && definition.instanceMemberMethodMirrors.isNotEmpty) {
        /// process instance @PostConstruct marked method
        List<MethodMirror> methodMirrors = definition.instanceMemberMethodMirrors;
        InstanceMirror instanceMirror = const Component().reflect(mirrorDefinitionHolder.instance);
        for (MethodMirror methodMirror in methodMirrors) {
          Object? keyCarrier = MetadataBeanUtils.declarationAnyMetadata<PostConstruct>(methodMirror);
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
  Map<String, WithoutBeanDefinitionHolder> _doParseReflectionConfiguration(List<ClassMirror> classMirrors) {
    Map<String, WithoutBeanDefinitionHolder> holders = {};

    for (ClassMirror classMirror in classMirrors) {
      BeanDefinition? definition = _mirrorDefinitions[classMirror.dynamicReflectedType];
      if (definition == null) {
        continue;
      }

      List<MethodMirror> methodMirrors = definition.instanceMemberMethodMirrors;
      dynamic dynamicInstance = definition.classMirror.newInstance('', []);
      InstanceMirror instanceMirror = const ComponentsConfiguration().reflect(dynamicInstance);

      for (MethodMirror methodMirror in methodMirrors) {
        Object? keyCarrier = MetadataBeanUtils.declarationReflectableMetadata<Component>(methodMirror);
        if (keyCarrier == null) {
          continue;
        }

        NamedReference? namedRef = MetadataUtils.findMetadata<NamedReference>(methodMirror.metadata);
        String? name = namedRef?.name;
        Object? returnInstance = instanceMirror.invoke(methodMirror.simpleName, []);
        if (returnInstance == null) {
          continue;
        }

        String key = _getKey(returnInstance.runtimeType, name);
        holders[key] = WithoutBeanDefinitionHolder(instanceMirror, methodMirror, name);
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
    for (BeanDefinitionHolder holder in _mirrorDefinitionHolders.values) {
      Map<String, VariableMirror> variableMirrors = holder.mirrorDefinition.variableFieldMirrors;
      for (var entry in variableMirrors.entries) {
        String fieldName = entry.key;
        VariableMirror variableMirror = entry.value;
        List<Object> carriers = variableMirror.metadata;

        Autowired? autowiredCarrier = MetadataUtils.findMetadata<Autowired>(carriers);
        if (autowiredCarrier == null) {
          continue;
        }

        String? tag = autowiredCarrier.name;
        dynamic dependency = findDependencyByCarrierName(variableMirror.dynamicReflectedType, tag);

        if (dependency == null) {
          throw NoSuchBeanDefinitionException(
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
      throw NoSuchBeanDefinitionException('not found mirror definition holder for type $S and name $tag');
    }
  }

  /// Process instance's @AfterPropertiesSet marked member method
  void _doProcessInstanceAfterPropertiesSet(List<BeanDefinitionHolder> mirrorDefinitionHolders) {
    for (BeanDefinitionHolder mirrorDefinitionHolder in mirrorDefinitionHolders) {
      /// process instance @AfterPropertiesSet marked method
      if (mirrorDefinitionHolder.instance != null &&
          mirrorDefinitionHolder.mirrorDefinition.instanceMemberMethodMirrors.isNotEmpty) {
        List<MethodMirror> methodMirrors = mirrorDefinitionHolder.mirrorDefinition.instanceMemberMethodMirrors;
        InstanceMirror instanceMirror = const Component().reflect(mirrorDefinitionHolder.instance);
        for (MethodMirror methodMirror in methodMirrors) {
          Object? keyCarrier = MetadataBeanUtils.declarationAnyMetadata<AfterPropertiesSet>(methodMirror);
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
    if (data is Map<Type, BeanDefinition>) {
      _logger.i('MirrorDefinitions collect start');
      for(var entry in data.entries) {
        _logger.i('Type=${entry.key}, MirrorDefinition=${entry.value.toString()}');
      }
      _logger.i('MirrorDefinitions collect end');
    } else if (data is Map<String, BeanDefinitionHolder>) {
      _logger.i('MirrorDefinitionHolders collect start, current is afterCircularDependencyInjection?: $afterCircularDependencyInjection');
      for(var entry in data.entries) {
        _logger.i('HolderName=${entry.key}, MirrorDefinitionHolder=${entry.value.toString()}');
      }
      _logger.i('MirrorDefinitionHolders collect end');
    } else if (data is Map<String, WithoutBeanDefinitionHolder>) {
      _logger.i('WithoutMirrorDefinitionHolders collect start');
      for(var entry in data.entries) {
        _logger.i('HolderName=${entry.key}, WithoutMirrorDefinitionHolder=${entry.value.toString()}');
      }
      _logger.i('WithoutMirrorDefinitionHolders collect end');
    }
  }
}
