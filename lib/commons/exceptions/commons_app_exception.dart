/// Common app abstract/base exception.
///
class CommonException implements Exception {
  final Object exception;
  final StackTrace stackTrace;

  CommonException(this.exception, this.stackTrace);

  @override
  String toString() {
    return "Redstonex common exception: $exception, $stackTrace";
  }
}
