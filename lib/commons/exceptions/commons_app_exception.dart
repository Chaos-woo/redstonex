/// Common app abstract/base exception.
///
class CommonsAppException implements Exception {
  final Object exception;
  final StackTrace stackTrace;

  CommonsAppException(this.exception, this.stackTrace);

  @override
  String toString() {
    return "Redstonex common app exception: $exception, $stackTrace";
  }
}
