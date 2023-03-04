
class XErrorCompose {
  static final XErrorCompose _single = XErrorCompose._internal();

  XErrorCompose._internal();

  factory XErrorCompose() => _single;

  ErrorCompose get common => ErrorCompose('ERR_NO_SPECIAL_COMMON', 'Internal Error');
}

class ErrorCompose {
  final String code;
  final String msg;

  ErrorCompose(this.code, this.msg);
}