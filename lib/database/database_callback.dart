import 'dart:async';

import 'package:sqflite/sqflite.dart';

/// Fired when the [database] has been just created with [version].
/// All actions are run within a single transaction.
///
class OnCreateCallback {
  final FutureOr<void> Function(
    Database database,
    int version,
  ) onCreate;

  const OnCreateCallback(this.onCreate);
}

/// Fired when the [database] has successfully been opened.
///
class OnOpenCallback {
  final FutureOr<void> Function(Database database) onOpen;

  const OnOpenCallback(this.onOpen);
}

/// Predicate current database version whether execute
/// [OnUpgradeCallback.onUpgrade] function.
typedef PredicateExecute = bool Function(int oldVersion, int newVersion);

/// Fired when the [database] has finished upgrading from [startVersion] to [endVersion].
/// All actions are run within a single transaction.
///
class OnUpgradeCallback {
  static const int databaseInitialVersion = 1;

  /// database upgrade handle function
  final Function(Database database) onUpgrade;

  /// predicate expression
  final PredicateExecute predicate;

  OnUpgradeCallback(this.onUpgrade, {required this.predicate});
}
