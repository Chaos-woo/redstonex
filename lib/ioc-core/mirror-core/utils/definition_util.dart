
import 'package:reflectable/reflectable.dart';

/// Mirror definition judgement util.
///
class DefinitionUtil {

  /// Get instance mirror from an real object.
  static InstanceMirror reflect(Reflectable reflector, Object instance) {
    return reflector.reflect(instance);
  }

  /// Whether a definition class
  static bool isDefinitionClass(ClassMirror classMirror) {
    return classMirror.isAbstract || classMirror.isEnum;
  }

  /// Whether not a definition class
  static bool isNotDefinitionClass(ClassMirror classMirror) {
    return !isDefinitionClass(classMirror);
  }

  /// Whether a definition method.
  static bool isDefinitionMethod(MethodMirror methodMirror) {
    return methodMirror.isAbstract
        || isConstructorMethod(methodMirror);
  }

  /// Whether not a definition method.
  static bool isNotDefinitionMethod(MethodMirror methodMirror) {
    return methodMirror.isAbstract
        || isConstructorMethod(methodMirror);
  }

  /// Whether a constructor method.
  static bool isConstructorMethod(MethodMirror methodMirror) {
    return methodMirror.isConstConstructor
        || methodMirror.isConstructor
        || methodMirror.isFactoryConstructor
        || methodMirror.isGenerativeConstructor
        || methodMirror.isRedirectingConstructor;
  }

  /// Whether a getter or setter method.
  static bool isGetterOrSetterMethod(MethodMirror methodMirror) {
    return methodMirror.isGetter || methodMirror.isSetter;
  }

  /// Whether a getter or setter method.
  static bool isOperatorMethod(MethodMirror methodMirror) {
    return methodMirror.isOperator;
  }

  /// Whether a regular method.
  /// Note that operators method is regular method.
  static bool isRegularMethod(MethodMirror methodMirror) {
    return methodMirror.isRegularMethod;
  }

  /// Whether a variable field.
  static bool isVariableField(VariableMirror variableMirror) {
    return !isNonVariableField(variableMirror);
  }

  /// Whether not a variable field.
  static bool isNonVariableField(VariableMirror variableMirror) {
    return variableMirror.isFinal || variableMirror.isConst;
  }
}