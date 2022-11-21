import 'dart:async';

import 'package:floor/floor.dart';
import 'package:redstonex/app-configs/global_config.dart';
import 'package:redstonex/database/base_repository.dart';
import 'package:redstonex/exceptions/redstonex_exception.dart';

import 'example_dao.dart';
import 'example_db.dart';

abstract class ExampleRootRepo<R> extends BaseRepository<ExampleDb, R> {
  /// Get database
  @override
  Future<ExampleDb> getDb() async {
    if (databaseInstance != null) {
      return databaseInstance!;
    }
    String dbName = GlobalConfig.of().globalDatabaseConfigs.databaseName;
    Callback cb = getCallback();
    ExampleDb instance =
        await $FloorExampleDb.databaseBuilder(dbName).addCallback(cb).build();
    databaseInstance = Future.value(instance);
    return databaseInstance!;
  }

  /// Get dao instance with generic type `R`
  @override
  Future<R> getDao() async {
    R? dao = await _innerDao();
    if (dao == null) {
      throw RSxException(RSxException.fixedErrCode, 'Unknown database dao instance');
    }
    return dao;
  }

  /// use inner method to get `R` type dao instance
  Future<R?> _innerDao() async {
    final db = await getDb();
    if (R is ExampleDao) {
      return db.exampleDao as R;
    }
    /// e.g.
    /// else if (.. is ..) {
    ///   return a `R` type of database getter
    /// } else {
    ///   return other `R` type
    /// }
    ///
    return null;
  }
}
