import 'package:floor/floor.dart';

class DatetimeNullConvertor extends TypeConverter<DateTime?, int?> {
  @override
  DateTime? decode(int? databaseValue) {
    return null != databaseValue ? DateTime.fromMillisecondsSinceEpoch(databaseValue) : null;
  }

  @override
  int? encode(DateTime? value) {
    return value?.millisecondsSinceEpoch;
  }
}
