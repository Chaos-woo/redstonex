import 'package:floor/floor.dart';

/// floor布尔值转换器
class rFloorBooleanConvertor extends TypeConverter<bool, int> {
  @override
  bool decode(int databaseValue) {
    return 0 == databaseValue ? false : true;
  }

  @override
  int encode(bool value) {
    return value ? 1 : 0;
  }
}
