
class ErrorStack implements Exception {
  final Object _err;
  final StackTrace _stackTrace;

  ErrorStack(this._err, this._stackTrace);

  StackTrace get stackTrace => _stackTrace;

  Object get err => _err;
}