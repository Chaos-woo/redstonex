import 'dart:async';

import 'package:sqflite/sqflite.dart';

/// 本地数据库创建回调
class OnCreateCallback {
  final FutureOr<void> Function(
    Database database,
    int version,
  ) onCreate;

  const OnCreateCallback(this.onCreate);
}

/// 本地数据库打开连接回调
class OnOpenCallback {
  final FutureOr<void> Function(Database database) onOpen;

  const OnOpenCallback(this.onOpen);
}

/// Predicate current database version whether execute
/// [OnUpgradeCallback.onUpgrade] function.
typedef PredicateExecute = bool Function(int oldVersion, int newVersion);

/// 本地数据库升级回调
class OnUpgradeCallback {
  static const int databaseInitialVersion = 1;

  /// database upgrade handle function
  final Function(Database database) onUpgrade;

  /// predicate expression
  final PredicateExecute predicate;

  OnUpgradeCallback(this.onUpgrade, {required this.predicate});
}
