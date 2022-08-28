import 'package:redstonex/commons/exceptions/app_exception.dart';

/// Default http exception.
///
///
class ServerException extends AppException {
  ServerException(int errCode, String message) : super(errCode, message);
}
