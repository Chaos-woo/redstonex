
class NoSuchMirrorDefinitionException implements Exception {
  final String message;

  NoSuchMirrorDefinitionException(this.message) : super();
}