import 'package:uuid/uuid.dart';

class XId {
  static final XId _single = XId._internal();

  XId._internal();

  factory XId() => _single;

  static const _uuid = Uuid();

  String uuidV4() => _uuid.v4();

  /// The number of milliseconds since
  /// the "Unix epoch" 1970-01-01T00:00:00Z (UTC).
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
}
