import 'package:uuid/uuid.dart';

class rId {
  static final rId _single = rId._internal();

  rId._internal();

  factory rId() => _single;

  static const _uuid = Uuid();

  String uuidV4() => _uuid.v4();

  /// The number of milliseconds since
  /// the "Unix epoch" 1970-01-01T00:00:00Z (UTC).
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
}
