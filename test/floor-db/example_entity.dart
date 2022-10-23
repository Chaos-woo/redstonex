
import 'package:floor/floor.dart';
import 'package:redstonex/exts/flutter-exts/string_ext.dart';
import 'package:redstonex/database-core/base_entity.dart';

import 'example.dart';

@Entity(tableName: 'tb_example')
class ExampleEntity extends BaseEntity {
  /// example content
  final String content;
  /// remark
  final String? remark;

  ExampleEntity(this.content, this.remark) : super();

  @override
  Example toVal() {
    return Example(content, remark, createdAt.datetime);
  }
}