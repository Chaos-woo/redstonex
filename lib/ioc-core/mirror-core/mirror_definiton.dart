import 'package:dartx/dartx.dart';
import 'package:redstonex/commons/log/loggers.dart';
import 'package:redstonex/ioc-core/mirror-core/utils/definition_util.dart';
import 'package:reflectable/reflectable.dart';

///  Holder mirror definition by parsing [ClassMirror] and [MethodMirror]
///  and [VariableMirror].
///
///  e.g.
///  Class type and method definition and variable definition
///  and metadata annotation definition
class MirrorDefinition {
  final ClassMirror _classMirror;
  late final Type _actualType;
  final List<Object> _classMetadatas = [];
  final Map<String, DeclarationMirror> _declarationMirrors = {};
  late final ClassMirror? _superclass;
  final List<ClassMirror> _superInterfaces = [];

  /// additional definition
  final List<MethodMirror> _instanceMemberMethodMirrors = [];
  final List<MethodMirror> _staticMethodMirrors = [];
  final List<VariableMirror> _variableFieldMirrors = [];
  final List<VariableMirror> _nonVariableFieldMirrors = [];

  MirrorDefinition(this._classMirror) {
    _reflectMirrorDefinition(_classMirror);

    _selfParseClassMirror();
    _selfParseMethodMirror();
    _selfParseVariableMirror();
  }

  void _reflectMirrorDefinition(ClassMirror classMirror) {
    _actualType = classMirror.dynamicReflectedType;
    _classMetadatas.addAll(classMirror.metadata);

    _declarationMirrors.addAll(classMirror.declarations);
  }

  void _selfParseClassMirror() {
    try {
      _superclass = _classMirror.superclass;
    } on NoSuchCapabilityError catch(e){
      _superclass = null;
      Loggers.of().w(e.stackTrace);
    } on Exception catch(e, stack) {
      _superclass = null;
      Loggers.of().e('self parse class superclass exception', e, stack);
    }

    _superInterfaces.addAll(_classMirror.superinterfaces);
  }

  void _selfParseMethodMirror() {
    for (var declarationEntry in _declarationMirrors.entries) {
      var declaration = declarationEntry.value;
      if (declaration is MethodMirror &&
          DefinitionUtil.isRegularMethod(declaration) &&
          !DefinitionUtil.isOperatorMethod(declaration)) {
        if (declaration.isStatic) {
          _staticMethodMirrors.add(declaration);
        } else {
          _instanceMemberMethodMirrors.add(declaration);
        }
      }
    }
  }

  void _selfParseVariableMirror() {
    for (var declarationEntry in _declarationMirrors.entries) {
      var declaration = declarationEntry.value;
      if (declaration is VariableMirror) {
        if (DefinitionUtil.isNonVariableField(declaration)) {
          _nonVariableFieldMirrors.add(declaration);
        } else if (DefinitionUtil.isVariableField(declaration)) {
          _variableFieldMirrors.add(declaration);
        }
      }
    }
  }

  List<VariableMirror> get nonVariableFieldMirrors => _nonVariableFieldMirrors.toUnmodifiable();

  List<VariableMirror> get variableFieldMirrors => _variableFieldMirrors.toUnmodifiable();

  List<MethodMirror> get staticMethodMirrors => _staticMethodMirrors.toUnmodifiable();

  List<MethodMirror> get instanceMemberMethodMirrors =>
      _instanceMemberMethodMirrors.toUnmodifiable();

  List<ClassMirror> get superInterfaces => _superInterfaces.toUnmodifiable();

  ClassMirror? get superclass => _superclass;

  Map<String, DeclarationMirror> get declarationMirrors => _declarationMirrors;

  List<Object> get classMetadatas => _classMetadatas.toUnmodifiable();

  Type get actualType => _actualType;

  ClassMirror get classMirror => _classMirror;
}
