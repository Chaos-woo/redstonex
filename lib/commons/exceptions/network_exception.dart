import 'package:redstonex/commons/exceptions/app_exception.dart';

/// Default http exception.
///
///
class NetworkException extends AppException {
  NetworkException(int errCode, String message) : super(errCode, message);
}
