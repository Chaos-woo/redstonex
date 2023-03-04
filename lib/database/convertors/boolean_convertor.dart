import 'package:floor/floor.dart';

class BooleanConvertor extends TypeConverter<bool, int> {
  @override
  bool decode(int databaseValue) {
    return 0 == databaseValue ? false : true;
  }

  @override
  int encode(bool value) {
    return value ? 1 : 0;
  }
}
