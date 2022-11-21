import 'package:floor/floor.dart';

/// Base dao interface.
///
/// No anything to used, for prompt only.
/// Use annotation [dao] and keyword `abstract`
/// to define your database interactions.
/// Use constant string define table name will
/// reduce your modification costs.
///
/// e.g.
/// @dao
/// abstract class Dao {
///   static const String tableName = 'table0';
///
///   @insert
///   Future<int> insertTodo(BaseEntity entity);
/// }
///
/// more floor information see also https://pub.dev/packages/floor
abstract class BaseDao {

}