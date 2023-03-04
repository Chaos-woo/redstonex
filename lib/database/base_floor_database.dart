import 'package:floor/floor.dart';
import 'package:redstonex/database/database_callback.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseFloorDatabase<T extends FloorDatabase> {
  /// 数据库实例
  T? _db;

  /// 创建数据库时的回调
  OnCreateCallback? _onCreateCallback;

  /// 打开数据库时的回调
  OnOpenCallback? _onOpenCallback;

  T get database => _db!;

  set database(T database) => _db = database;

  /// 存储 [OnUpgradeCallback] 库表升级回调
  final List<OnUpgradeCallback> _onUpgradeCallbacks = [];

  void registerOnCreateCallback(OnCreateCallback cb) => _onCreateCallback = cb;

  void registerOnOpenCallback(OnOpenCallback cb) => _onOpenCallback = cb;

  /// 注册数据库版本升级更新回调（在数据库创建和连接后执行）
  void addOnUpgradeCallback(OnUpgradeCallback cb) => _onUpgradeCallbacks.add(cb);

  Callback getFloorDatabaseCallback() {
    return Callback(
      onCreate: (db, version) => _onCreateCallback?.onCreate.call(db, version),
      onOpen: (db) => _onOpenCallback?.onOpen.call(db),
      onUpgrade: (db, int oldVersion, int newVersion) => _migrationUpgrade(db, oldVersion, newVersion),
    );
  }

  /// 数据迁移升级
  void _migrationUpgrade(db, int oldVersion, int newVersion) {
    /// 按照升级回调的升级版本排序
    _onUpgradeCallbacks.sort((cb1, cb2) => cb1.fromVersion.compareTo(cb2.fromVersion));

    /// 过滤当前数据库版本之前的回调处理
    List<OnUpgradeCallback> effectiveUpgradeCbs =
        _onUpgradeCallbacks.where((cb) => cb.fromVersion >= oldVersion).toList();

    /// 依次执行升级回调，直至最新版本。支持逐级升级和跨版本升级
    for (var cb in effectiveUpgradeCbs) {
      int oldVer = oldVersion;
      int newVer = newVersion;
      Batch batch = db.batch();
      cb.onUpgrade.call(batch, oldVer, newVer);
    }
  }

  void initializeDatabase();
}
