import 'dart:async';

import 'package:sqflite/sqflite.dart';

/// 本地数据库创建回调
/// 首次创建数据库时，需要建表、初始化数据放在这里
abstract class OnCreateCallback {
  FutureOr<void> Function(Database database, int version) get onCreate;
}

/// 本地数据库打开连接回调
/// 每次打开本地数据库都会调用
class OnOpenCallback {
  final FutureOr<void> Function(Database database) onOpen;

  const OnOpenCallback(this.onOpen);
}

/// 本地数据库升级回调
abstract class OnUpgradeCallback {
  Function(Batch batch, int oldVersion, int newVersion) get onUpgrade;

  int get fromVersion;
}
