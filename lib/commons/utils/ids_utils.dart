
import 'package:uuid/uuid.dart';

/// A multifarious id generator.
///
///
class IdsUtil {
  static const _uuid = Uuid();

  static String uuidV4() => _uuid.v4();

  /// The number of milliseconds since
  /// the "Unix epoch" 1970-01-01T00:00:00Z (UTC).
  static String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
}