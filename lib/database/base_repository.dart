import 'package:floor/floor.dart';
import 'package:redstonex/database/database_callback.dart';

/// 基础仓库类
abstract class BaseRepository<T extends FloorDatabase, R> {
  /// 全局唯一本地数据库实例，对数据库名对应
  Future<T>? databaseInstance;

  /// 创建数据库时的回调
  OnCreateCallback? _onCreateCb;

  /// 打开数据库时的回调
  OnOpenCallback? _onOpenCb;

  /// 存储 [OnUpgradeCallback] 库表升级回调
  final List<OnUpgradeCallback> _onUpgradeCbs = [];

  void registerDbCreateCb(OnCreateCallback cb) => _onCreateCb = cb;

  void registerDbOpenCb(OnOpenCallback cb) => _onOpenCb = cb;

  /// 注册数据库版本升级更新回调（在数据库创建和连接后执行）
  void registerDbUpgradeCb(OnUpgradeCallback cb) => _onUpgradeCbs.add(cb);

  /// 建议该方法仅在 [getDbInstance] 获取数据库实例中使用
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

  /// 获取数据库实例
  Future<T> getDbInstance();

  /// 获取指定类型的dao类
  Future<R> getDao();
}
