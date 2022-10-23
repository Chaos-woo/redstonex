class RsException implements Exception {
  static int fixedErrCode = -1;

  final int _code;
  final String _msg;

  RsException(this._code, this._msg);

  int get code => _code;

  String get msg => _msg;
}
