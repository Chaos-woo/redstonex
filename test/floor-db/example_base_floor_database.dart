import 'dart:async';

import 'package:floor/floor.dart';
import 'package:redstonex/redstonex.dart';
import 'package:sqflite_common/sqlite_api.dart' as sql_api;

import 'example_db.dart';

// void testDatabaseExample() {
//   EDb().initializeDatabase();
//
//   var db = EDb().database;
//   db.exampleDao.findById(1);
// }

class EDb extends ExampleBaseFloorDatabase {
  static final EDb _single = EDb._internal();

  EDb._internal();

  factory EDb() => _single;
}

abstract class ExampleBaseFloorDatabase extends BaseFloorDatabase<ExampleDb> {
  @override
  void initializeDatabase() async {
    _setupCallbackRegister();

    String dbName = 'db_example';
    Callback cb = getFloorDatabaseCallback();
    ExampleDb instance = await $FloorExampleDb.databaseBuilder(dbName).addCallback(cb).build();
    super.database = instance;
  }

  void _setupCallbackRegister() {
    /// 注册数据库创建回调
    registerOnCreateCallback(ExampleDbOnCreateCallback());

    /// 注册数据库打开回调
    registerOnOpenCallback(ExampleDbOnOpenCallback());

    /// 添加升级回调
    addOnUpgradeCallback(ExampleDbOnUpdateCallbackV1());
    addOnUpgradeCallback(ExampleDbOnUpdateCallbackV2());
  }
}

class ExampleDbOnCreateCallback extends OnCreateCallback {
  @override
  FutureOr<void> Function(sql_api.Database database, int version) get onCreate => (db, version) {
    XLog().debug('example database create');
  };

}

class ExampleDbOnOpenCallback extends OnOpenCallback {
  @override
  FutureOr<void> Function(sql_api.Database database) get onOpen => (db) {
    XLog().debug('example database open');
  };

}

class ExampleDbOnUpdateCallbackV1 extends OnUpgradeCallback {
  @override
  int get fromVersion => 1;

  @override
  Function(sql_api.Batch batch, int oldVersion, int newVersion) get onUpgrade => (batch, oldVersion, newVersion) {
    XLog().debug('example database upgrade V1');
  };

}

class ExampleDbOnUpdateCallbackV2 extends OnUpgradeCallback {
  @override
  int get fromVersion => 2;

  @override
  Function(sql_api.Batch batch, int oldVersion, int newVersion) get onUpgrade => (batch, oldVersion, newVersion) {
    XLog().debug('example database upgrade V2');
  };

}