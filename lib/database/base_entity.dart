import 'package:floor/floor.dart';

/// 本地数据库实体类基础属性，真实业务实体应使用 [Entity] 注解
abstract class BaseEntity {
  /// primary key
  @PrimaryKey(autoGenerate: true)
  final int? id;

  /// created time
  @ColumnInfo(name: 'created_at')
  final String createdAt;

  /// updated time
  @ColumnInfo(name: 'updated_at')
  final String updatedAt;

  BaseEntity({
    this.id,
    String? createdAt,
    String? updateAt,
  })  : createdAt = createdAt ?? DateTime.now().toIso8601String(),
        updatedAt = updateAt ?? DateTime.now().toIso8601String();
}
