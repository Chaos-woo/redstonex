import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../extension/string_extension.dart';

class EpochMillisecondDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochMillisecondDateTimeConverter();

  @override
  DateTime fromJson(int json) {
    return DateTime.fromMillisecondsSinceEpoch(json);
  }

  @override
  int toJson(DateTime object) {
    return object.millisecondsSinceEpoch;
  }
}

class EpochSecondDateTimeConverter implements JsonConverter<DateTime, int> {
  const EpochSecondDateTimeConverter();

  @override
  DateTime fromJson(int json) {
    return DateTime.fromMillisecondsSinceEpoch(json * 1000);
  }

  @override
  int toJson(DateTime object) {
    return object.millisecondsSinceEpoch ~/ 1000;
  }
}

abstract class GenericDateTimeConverter implements JsonConverter<DateTime, String> {
  @override
  DateTime fromJson(String json) {
    return json.parseDateTime;
  }

  @override
  String toJson(DateTime object) {
    return datetimeFormat().format(object);
  }

  DateFormat datetimeFormat();
}
