import 'package:redstonex/commons/exceptions/app_exception.dart';

/// Default http exception.
///
///
class UnauthorisedException extends AppException {
  UnauthorisedException(int errCode, String message) : super(errCode, message);
}
