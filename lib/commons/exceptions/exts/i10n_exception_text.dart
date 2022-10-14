import 'package:redstonex/commons/exceptions/app_exception.dart';

///
/// An app exception multi language error message.
///
/// Note: extends [I10nBaseExceptionText] and put in GetX bean container,
/// tag only is [AppException.fixedI10nTag]
class I10nBaseExceptionText {
  String get cancelRequest => 'Cancel request';

  String get connectTimeout => 'Connect timeout';

  String get writeTimeout => 'Request timeout';

  String get readTimeout => 'Read timeout';

  String get err400 => 'Bad request';

  String get err401 => 'No authenticated';

  String get err403 => 'No access';

  String get err404 => 'Not found';

  String get err405 => 'Method forbidden';

  String get err500 => 'Internal server error';

  String get err502 => 'No response';

  String get err503 => 'Service unavailable';

  String get err505 => 'Version not supported';

  String get errUnknown => 'Unknown error';

  String get errDef => '';
}