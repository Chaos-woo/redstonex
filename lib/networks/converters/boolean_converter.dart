import 'package:json_annotation/json_annotation.dart';

class BoolIntConverter implements JsonConverter<bool, int> {
  @override
  bool fromJson(int json) {
    return 0 == json ? false : true;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}

class BoolStringConverter implements JsonConverter<bool, String> {
  @override
  bool fromJson(String json) {
    return 'true' == json.toLowerCase();
  }

  @override
  String toJson(bool object) {
    return object ? 'true' : 'false';
  }
}
