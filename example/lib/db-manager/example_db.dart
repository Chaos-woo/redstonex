import 'dart:async';

import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:example/db-manager/example_dao.dart';
import 'package:floor/floor.dart';
import 'package:redstonex/redstonex.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'example_db.g.dart';

/// the generated code will be there

/// A floor database interface example.
///
/// Refer to the file under `floor-db` package for
/// relevant contents. From entity, value object,
/// dao, to business repository. Simple floor use can
/// be completed according to `floor-db`.
///
/// For this example class, note the following:
///   * [Database.version] only can be upgrade and [Callback]
///   can upgrade database tables according modified sql.
///   * [Database.entities] and [ExampleDb.xxxDao] should
///   be matched one by one. Like [ExampleEntity] and
///   [ExampleDb.biliFavoriteVideoDao].
///   * Implementation class of [BaseRepository] should
///   complete [BaseRepository.getDbInstance] and [BaseRepository.getDao].
///   Even if [BaseRepository.getDao] is not used in business,
///   relevant methods for obtaining xxxDao should be provided.
///
/// Generate `xx_database.g.dart` with `flutter packages pub run build_runner build --delete-conflicting-outputs`
///
/// How to write upgrade logic, see also:
///   * https://stackoverflow.com/questions/63347032/how-do-you-upgrade-a-flutter-app-with-sqlite-database
@TypeConverters([DatetimeConvertor, DatetimeNullConvertor])
@Database(version: 1, entities: [BiliFavoriteVideo])
abstract class ExampleDb extends FloorDatabase {
  BiliFavoriteVideoDao get biliFavoriteVideoDao;
}
