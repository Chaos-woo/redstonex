import 'example.dart';
import 'example_dao.dart';
import 'example_entity.dart';
import 'example_root_repo.dart';

/// Real repository, for business repository.
///
class ExampleRealRepo extends ExampleRootRepo<ExampleDao> {
  Future<Example?> findById(int id) async {
    final ExampleDao dao = await getDao();
    ExampleEntity? entity = await dao.findById(id);
    return entity?.toVal();
  }
}