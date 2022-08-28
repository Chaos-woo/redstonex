import 'package:floor/floor.dart';
import 'package:redstonex/commons/standards/to_val_syntax.dart';

/// Base entity properties
///
/// Local database entity necessary attributes,
/// continue to use the `abstract` keyword to describe
/// the key attributes of your database, and the real
/// entity is decorated with annotation [Entity]
abstract class BaseEntity<V> with ToValSyntax<V>{
  /// primary key
  @PrimaryKey(autoGenerate: true)
  final int? id;

  /// created time
  @ColumnInfo(name: 'created_at')
  final String createdAt;

  /// updated time
  @ColumnInfo(name: 'updated_at')
  final String updatedAt;

  BaseEntity(
    this.id, {
    String? createdAt,
    String? updateAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updateAt ?? DateTime.now().toIso8601String();
}
