import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/ioc-core/metadata-core/reflection.dart';
import 'package:redstonex/ioc-core/metadata-core/reflection_configuration.dart';
import 'package:redstonex/ioc-core/reflectable-core/utils/reflections_util.dart';
import 'package:redstonex/ioc-core/self_reflectable.dart';
import 'package:reflectable/reflectable.dart';
import 'package:test/test.dart';

import 'example_mirrors_test.reflectable.dart';

// @registerRef
@Record('theA')
@recordRef
@Reflection()
class RefA {
  RefA() {}

  @Record('theMethodA')
  void methodA() {}

  TestV? test;
}

class TestV {
  String? v;
  String? m;
}

@RefsConfiguration()
class RefsConfig {
  @Reflection()
  TestV testV() => TestV();
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

  // test('mirrors initial test', () {
  //   RegisterRefHandler handler = RegisterRefHandler();
  //   handler.handle();
  //   Loggers.of().i(Refs.ref<RefA>());
  // });

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

        var executeCm = recordRef.reflect(newInstance);

        executeCm.invokeSetter(entry.key, TestV());
      } else if (variable is MethodMirror) {
        Loggers.of().i('method ${entry.key}');
      }
    }

    print('$newInstance');
  });

  test('auto reflectable', () {
    SelfReflectable.startSelfRegistered();

    print('${ReflectionsUtil.find<RefA>()}');
    print('${ReflectionsUtil.find<TestV>()}');
  });
}
