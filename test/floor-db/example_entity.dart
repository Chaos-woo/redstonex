
import 'package:floor/floor.dart';
import 'package:redstonex/database/base_entity.dart';

import 'example.dart';

@Entity(tableName: 'tb_example')
class ExampleEntity extends BaseEntity {
  /// example content
  final String content;
  /// remark
  final String? remark;

  ExampleEntity(this.content, this.remark) : super();

  Example toVal() {
    return Example(content, remark, DateTime.parse(createdAt));
  }
}