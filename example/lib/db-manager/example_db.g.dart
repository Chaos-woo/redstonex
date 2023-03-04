// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorExampleDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ExampleDbBuilder databaseBuilder(String name) =>
      _$ExampleDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ExampleDbBuilder inMemoryDatabaseBuilder() =>
      _$ExampleDbBuilder(null);
}

class _$ExampleDbBuilder {
  _$ExampleDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ExampleDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ExampleDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ExampleDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ExampleDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ExampleDb extends ExampleDb {
  _$ExampleDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BiliFavoriteVideoDao? _biliFavoriteVideoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tb_bili_video_favorite` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `bvid` TEXT NOT NULL, `tag` TEXT NOT NULL, `pic` TEXT NOT NULL, `title` TEXT NOT NULL, `publish_date` INTEGER NOT NULL, `short_link` TEXT NOT NULL, `up` TEXT NOT NULL, `created_at` INTEGER NOT NULL, `updated_at` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BiliFavoriteVideoDao get biliFavoriteVideoDao {
    return _biliFavoriteVideoDaoInstance ??=
        _$BiliFavoriteVideoDao(database, changeListener);
  }
}

class _$BiliFavoriteVideoDao extends BiliFavoriteVideoDao {
  _$BiliFavoriteVideoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _biliFavoriteVideoInsertionAdapter = InsertionAdapter(
            database,
            'tb_bili_video_favorite',
            (BiliFavoriteVideo item) => <String, Object?>{
                  'id': item.id,
                  'bvid': item.bVid,
                  'tag': item.tag,
                  'pic': item.pic,
                  'title': item.title,
                  'publish_date': _datetimeConvertor.encode(item.publishData),
                  'short_link': item.shortLink,
                  'up': item.up,
                  'created_at': _datetimeConvertor.encode(item.createdAt),
                  'updated_at': _datetimeConvertor.encode(item.updatedAt)
                }),
        _biliFavoriteVideoUpdateAdapter = UpdateAdapter(
            database,
            'tb_bili_video_favorite',
            ['id'],
            (BiliFavoriteVideo item) => <String, Object?>{
                  'id': item.id,
                  'bvid': item.bVid,
                  'tag': item.tag,
                  'pic': item.pic,
                  'title': item.title,
                  'publish_date': _datetimeConvertor.encode(item.publishData),
                  'short_link': item.shortLink,
                  'up': item.up,
                  'created_at': _datetimeConvertor.encode(item.createdAt),
                  'updated_at': _datetimeConvertor.encode(item.updatedAt)
                }),
        _biliFavoriteVideoDeletionAdapter = DeletionAdapter(
            database,
            'tb_bili_video_favorite',
            ['id'],
            (BiliFavoriteVideo item) => <String, Object?>{
                  'id': item.id,
                  'bvid': item.bVid,
                  'tag': item.tag,
                  'pic': item.pic,
                  'title': item.title,
                  'publish_date': _datetimeConvertor.encode(item.publishData),
                  'short_link': item.shortLink,
                  'up': item.up,
                  'created_at': _datetimeConvertor.encode(item.createdAt),
                  'updated_at': _datetimeConvertor.encode(item.updatedAt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BiliFavoriteVideo> _biliFavoriteVideoInsertionAdapter;

  final UpdateAdapter<BiliFavoriteVideo> _biliFavoriteVideoUpdateAdapter;

  final DeletionAdapter<BiliFavoriteVideo> _biliFavoriteVideoDeletionAdapter;

  @override
  Future<List<BiliFavoriteVideo>> listBiliFavoriteVideos() async {
    return _queryAdapter.queryList('SELECT * FROM tb_bili_video_favorite',
        mapper: (Map<String, Object?> row) => BiliFavoriteVideo(
            bVid: row['bvid'] as String,
            tag: row['tag'] as String,
            pic: row['pic'] as String,
            title: row['title'] as String,
            publishData: _datetimeConvertor.decode(row['publish_date'] as int),
            shortLink: row['short_link'] as String,
            up: row['up'] as String,
            createdAt: _datetimeConvertor.decode(row['created_at'] as int),
            updatedAt: _datetimeConvertor.decode(row['updated_at'] as int),
            id: row['id'] as int?));
  }

  @override
  Future<BiliFavoriteVideo?> selectByBVid(String bVid) async {
    return _queryAdapter.query(
        'SELECT * FROM tb_bili_video_favorite WHERE bvid = ?1',
        mapper: (Map<String, Object?> row) => BiliFavoriteVideo(
            bVid: row['bvid'] as String,
            tag: row['tag'] as String,
            pic: row['pic'] as String,
            title: row['title'] as String,
            publishData: _datetimeConvertor.decode(row['publish_date'] as int),
            shortLink: row['short_link'] as String,
            up: row['up'] as String,
            createdAt: _datetimeConvertor.decode(row['created_at'] as int),
            updatedAt: _datetimeConvertor.decode(row['updated_at'] as int),
            id: row['id'] as int?),
        arguments: [bVid]);
  }

  @override
  Future<List<BiliFavoriteVideo>> pagingByMinId(
    int id,
    int limit,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM tb_bili_video_favorite WHERE id > ?1 order by id asc limit ?2',
        mapper: (Map<String, Object?> row) => BiliFavoriteVideo(bVid: row['bvid'] as String, tag: row['tag'] as String, pic: row['pic'] as String, title: row['title'] as String, publishData: _datetimeConvertor.decode(row['publish_date'] as int), shortLink: row['short_link'] as String, up: row['up'] as String, createdAt: _datetimeConvertor.decode(row['created_at'] as int), updatedAt: _datetimeConvertor.decode(row['updated_at'] as int), id: row['id'] as int?),
        arguments: [id, limit]);
  }

  @override
  Future<int> insert0(BiliFavoriteVideo record) {
    return _biliFavoriteVideoInsertionAdapter.insertAndReturnId(
        record, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> batchInsert0(List<BiliFavoriteVideo> records) {
    return _biliFavoriteVideoInsertionAdapter.insertListAndReturnIds(
        records, OnConflictStrategy.abort);
  }

  @override
  Future<int> update0(BiliFavoriteVideo record) {
    return _biliFavoriteVideoUpdateAdapter.updateAndReturnChangedRows(
        record, OnConflictStrategy.abort);
  }

  @override
  Future<int> batchUpdate0(List<BiliFavoriteVideo> records) {
    return _biliFavoriteVideoUpdateAdapter.updateListAndReturnChangedRows(
        records, OnConflictStrategy.abort);
  }

  @override
  Future<int> delete0(BiliFavoriteVideo record) {
    return _biliFavoriteVideoDeletionAdapter.deleteAndReturnChangedRows(record);
  }

  @override
  Future<int> batchDelete0(List<BiliFavoriteVideo> records) {
    return _biliFavoriteVideoDeletionAdapter
        .deleteListAndReturnChangedRows(records);
  }
}

// ignore_for_file: unused_element
final _datetimeConvertor = DatetimeConvertor();
final _datetimeNullConvertor = DatetimeNullConvertor();
