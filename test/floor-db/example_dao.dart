import 'package:floor/floor.dart';

import 'example_entity.dart';

@dao
abstract class ExampleDao {
  static const String exampleTable = 'tb_example';

  @Query('SELECT * FROM $exampleTable WHERE id=:id')
  Future<ExampleEntity?> findById(int id);
}
