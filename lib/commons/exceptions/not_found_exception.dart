import 'package:redstonex/commons/exceptions/app_exception.dart';

/// Default http exception.
///
///
class NotFoundException extends AppException {
  NotFoundException(int errCode, String message) : super(errCode, message);
}
