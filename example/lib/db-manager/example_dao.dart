import 'package:example/db-manager/entity/bili_favorite_video.dart';
import 'package:floor/floor.dart';
import 'package:redstonex/redstonex.dart';

@dao
abstract class BiliFavoriteVideoDao extends rBaseDao<BiliFavoriteVideo> {
  static const String tableName = 'tb_bili_video_favorite';

  @Query("SELECT * FROM $tableName")
  Future<List<BiliFavoriteVideo>> listBiliFavoriteVideos();

  @Query("SELECT * FROM $tableName WHERE bvid = :bVid")
  Future<BiliFavoriteVideo?> selectByBVid(String bVid);

  @Query("SELECT * FROM $tableName WHERE id > :id order by id asc limit :limit")
  Future<List<BiliFavoriteVideo>> pagingByMinId(int id, int limit);
}
