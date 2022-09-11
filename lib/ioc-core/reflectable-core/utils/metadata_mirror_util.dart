import 'package:dartx/dartx.dart';
import 'package:reflectable/reflectable.dart';

/// Mirror-Metadata relation parse util.
///
class MetadataMirrorUtil {
  static List<ClassMirror> annotatedClass(Reflectable reflector) {
    return reflector.annotatedClasses.toList().toUnmodifiable();
  }

  static List<Object> classAnnotationCarriers(ClassMirror classMirror) {
    return classMirror.metadata.whereNot((ele) => ele is Reflectable).toList().toUnmodifiable();
  }

  static List<Object> declarationAnnotationCarriers(DeclarationMirror declarationMirror) {
    return declarationMirror.metadata.whereNot((ele) => ele is Reflectable).toList().toUnmodifiable();
  }
}
