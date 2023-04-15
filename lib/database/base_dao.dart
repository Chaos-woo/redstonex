import 'package:floor/floor.dart';

/// Floor https://pub.dev/packages/floor
abstract class BaseDao<T> {
  @insert
  Future<int> insert0(T record);

  @insert
  Future<List<int>> batchInsert0(List<T> records);

  @update
  Future<int> update0(T record);

  @update
  Future<int> batchUpdate0(List<T> records);

  @delete
  Future<int> delete0(T record);

  @delete
  Future<int> batchDelete0(List<T> records);
}
