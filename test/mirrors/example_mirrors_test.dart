import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/after_properties_set.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/autowired.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/named_reference.dart';
import 'package:redstonex/ioc-core/metadata-core/carriers/post_construct.dart';
import 'package:redstonex/ioc-core/metadata-core/reflection.dart';
import 'package:redstonex/ioc-core/metadata-core/reflection_configuration.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/metadata_mirror_utils.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/reflections_utils.dart';
import 'package:redstonex/ioc-core/self_reflectable.dart';
import 'package:reflectable/reflectable.dart';
import 'package:test/test.dart';

import 'example_mirrors_test.reflectable.dart';

@Record('theA')
@recordRef
@Reflection()
class RefA {
  RefA() {}

  @Record('theMethodA')
  void methodA() {}

  @Autowired()
  TestV test = TestV();

  AnyClass? anyClass;

  @PostConstruct()
  void postConstruct() {
    Loggers.of().i('postConstruct method invoke');
  }

  @AfterPropertiesSet()
  void afterPropertiesSet() {
    Loggers.of().i('afterPropertiesSet method invoke');
  }
}

class AnyClass {

}

class TestV {
  String? v;
  String? m;
}

@Reflection()
@NamedReference(name: 'theNamed')
class NamedRefTest {

}

@RefsConfiguration()
class RefsConfig {
  @Reflection()
  TestV testV() {
   TestV t = TestV();
   t.m = 'm';
   t.v = 'v';
   return t;
  }
}

class RecordRef extends Reflectable {
  const RecordRef() : super(typingCapability, invokingCapability);
}

const recordRef = RecordRef();

class Record {
  final String? name;

  const Record(this.name);
}

void main() {
  initializeReflectable(); // 自定义方法名开启reflectable反射的支持

  GlobalConfig.safePutGlobalConfig(GlobalConfig());

  /// 结论：使用有metadataCapability的注解，可以获取到类上
  ///     、方法上、参数上的注解(其他注解)信息，且可以获取到
  ///     其他注解中自带的属性信息
  test('list meta', () {
    // 添加了新的Reflectable类之后要重新build一下生成新的*.reflectable.dart类
    List<ClassMirror> cms = recordRef.annotatedClasses.toList();
    ClassMirror cm = cms[0];

    Object newInstance = cm.newInstance('', []);

    Loggers.of().i('class === ');

    List<Object> metaData = cm.metadata;
    for (var value in metaData) {
      /// 打印结果：
      /// 💡 not Record, but Instance of 'RegisterRef'
      /// 💡 theA
      /// 💡 not Record, but Instance of 'RecordRef'
      ///
      /// 结论：可以读取到类上的元注解信息
      if (value is Record) {
        Loggers.of().i(value.name);
      } else {
        Loggers.of().i('not Record, but $value');
      }
    }

    List<MethodMirror> methods = cm.instanceMembers.values.toList();
    MethodMirror? mm;
    for (var m in methods) {
      if (m.metadata.isNotEmpty) {
        mm = m;
        break;
      }
    }

    Loggers.of().i('method === ');

    metaData = mm!.metadata;
    for (var value in metaData) {
      /// 打印结果：
      /// 💡 theMethodA
      ///
      /// 结论：可以读取到方法上的元注解信息
      if (value is Record) {
        Loggers.of().i(value.name);
      } else {
        Loggers.of().i('not Record, but $value');
      }
    }

    Loggers.of().i(' Variable === ');

    Map<String, DeclarationMirror> declarations = cm.declarations;
    for (var entry in declarations.entries) {
      // Loggers.of().i(entry.key);

      var variable = entry.value;
      if (variable is VariableMirror) {
        Loggers.of().w('variable ${entry.key}');

        Object? reflectable = MetadataMirrorUtil.declarationReflectableMetadata(variable);
        if (reflectable == null) {
          continue;
        }

        var executeCm = recordRef.reflect(newInstance);

        executeCm.invokeSetter(entry.key, TestV());
      } else if (variable is MethodMirror) {
        Loggers.of().i('method ${entry.key}');
      }
    }

    print('$newInstance');
  });

  /// 测试IoC和DI
  /// 1.测试RefA类的生成管理
  /// 2.测试RefA类@Autowired()依赖的自动注入
  /// 3.测试RefA类@PostConstruct()方法的自动执行
  /// 4.测试RefA类@AfterPropertiesSet()方法的自动执行
  ///
  /// 5.测试@RefsConfiguration()配置类配置类注入容器（TestV类）
  test('auto reflectable', () {
    SelfReflectable.startSelfRegistered();

    print('${ReflectionsUtil.find<RefA>()}');
    print('${ReflectionsUtil.find<TestV>()}');
  });
}
