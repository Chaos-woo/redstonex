import 'package:dartx/dartx.dart';
import 'package:reflectable/reflectable.dart';

/// Mirror-Metadata relation parse util.
///
class MetadataMirrorUtil {
  static List<ClassMirror> annotatedClass(Reflectable reflector) {
    return reflector.annotatedClasses.toList().toUnmodifiable();
  }

  static List<Object> classMetadataCarriers(ClassMirror classMirror) {
    return classMirror.metadata.whereNot((ele) => ele is Reflectable).toList().toUnmodifiable();
  }

  static List<Object> declarationMetadataCarriers(DeclarationMirror declarationMirror) {
    return declarationMirror.metadata.whereNot((ele) => ele is Reflectable).toList().toUnmodifiable();
  }

  static Object? declarationReflectableMetadata<S>(DeclarationMirror declarationMirror) {
    return declarationMirror.metadata.filter((ele) => ele is Reflectable).filter((ele) => ele is S).firstOrNull;
  }
}
