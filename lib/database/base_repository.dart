import 'package:floor/floor.dart';
import 'package:redstonex/database/database_callback.dart';
import 'package:sqflite/sqflite.dart';

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
      onUpgrade: (db, int oldVersion, int newVersion) async {
        Batch batch = db.batch();
        /// 按照升级回调的升级版本排序
        _onUpgradeCbs.sort((cb1, cb2) => cb1.fromVersion.compareTo(cb2.fromVersion));
        /// 过滤当前数据库版本之前的回调处理
        List<OnUpgradeCallback> localUpgradeCbs = _onUpgradeCbs
            .where((element) => element.fromVersion > oldVersion).toList();
        /// 依次执行升级回调，直至最新版本。支持逐级升级和跨版本升级
        for (var element in localUpgradeCbs) {
          int oldVer = oldVersion;
          int newVer = newVersion;
          element.onUpgrade.call(batch, oldVer, newVer);
        }
      },
    );
  }

  /// 获取数据库实例
  Future<T> getDbInstance();

  /// 获取指定类型的dao类
  Future<R> getDao();
}
