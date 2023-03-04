import 'package:floor/floor.dart';

@Entity(tableName: 'tb_example')
class ExampleEntity {
  @primaryKey
  int? id;

  /// example content
  final String content;

  /// remark
  final String? remark;

  ExampleEntity(this.content, this.remark) : super();
}
