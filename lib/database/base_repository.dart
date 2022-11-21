import 'package:floor/floor.dart';
import 'package:redstonex/database/database_callback.dart';

/// Base repository.
///
abstract class BaseRepository<T extends FloorDatabase, R> {
  /// global unique singleton database instance
  Future<T>? databaseInstance;

  /// create database callback
  OnCreateCallback? _onCreateCb;

  /// opened database callback
  OnOpenCallback? _onOpenCb;

  /// saved [OnUpgradeCallback] functions
  final List<OnUpgradeCallback> _onUpgradeCbs = [];

  void registerDbCreateCb(OnCreateCallback cb) => _onCreateCb = cb;

  void registerDbOpenCb(OnOpenCallback cb) => _onOpenCb = cb;

  /// Register database version change callback,
  /// and wait to execute after database created and opened
  void registerDbUpgradeCb(OnUpgradeCallback cb) => _onUpgradeCbs.add(cb);

  /// Recommend to use only in [getDb]
  Callback getCallback() {
    return Callback(
      onCreate: (db, version) {
        _onCreateCb?.onCreate.call(db, version);
      },
      onOpen: (db) {
        _onOpenCb?.onOpen.call(db);
      },
      onUpgrade: (db, int oldVersion, int newVersion) {
        for (OnUpgradeCallback cb in _onUpgradeCbs) {
          if (cb.predicate.call(oldVersion, newVersion)) {
            cb.onUpgrade.call(db);
          }
        }
      },
    );
  }

  /// Get database
  Future<T> getDb();

  /// Get dao instance with generic type `R`
  Future<R> getDao();
}
