import 'package:redstonex/exceptions/error_consts.dart';

class RsxInternalException implements Exception {
  final String code;
  final String msg;

  RsxInternalException(this.code, this.msg);

  RsxInternalException.compose(ErrorCompose compose)
      : code = compose.code,
        msg = compose.msg;
}
