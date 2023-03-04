import 'package:example/db-manager/example_dao.dart';
import 'package:floor/floor.dart';

@Entity(tableName: BiliFavoriteVideoDao.tableName)
class BiliFavoriteVideo {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'bvid')
  final String bVid;

  @ColumnInfo(name: 'tag')
  final String tag;

  @ColumnInfo(name: 'pic')
  final String pic;

  @ColumnInfo(name: 'title')
  final String title;

  @ColumnInfo(name: 'publish_date')
  final DateTime publishData;

  @ColumnInfo(name: 'short_link')
  final String shortLink;

  @ColumnInfo(name: 'up')
  final String up;

  @ColumnInfo(name: "created_at")
  final DateTime createdAt;

  @ColumnInfo(name: "updated_at")
  final DateTime updatedAt;

  BiliFavoriteVideo({
    required this.bVid,
    required this.tag,
    required this.pic,
    required this.title,
    required this.publishData,
    required this.shortLink,
    required this.up,
    required this.createdAt,
    required this.updatedAt,
    this.id,
  });

  @override
  String toString() {
    return 'BiliFavoriteVideo{id: $id, bVid: $bVid, tag: $tag, pic: $pic, title: $title, publishData: $publishData, shortLink: $shortLink, up: $up, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
