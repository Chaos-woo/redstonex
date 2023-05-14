import 'package:example/services/models/bili_hot_video_recommend_reason.dart';
import 'package:example/services/models/bili_hot_video_stat.dart';
import 'package:example/services/models/bili_up.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bili_hot_video.g.dart';

@JsonSerializable()
class BiliHotVideo {
  late int aid;

  @JsonKey(name: 'tname')
  late String tagName;

  late String pic;

  late String title;

  @JsonKey(name: 'pubdate')
  late int pubDate;

  @JsonKey(name: 'short_link_v2')
  late String shortLink;

  @JsonKey(name: 'bvid')
  late String bVid;

  late BiliUp owner;

  @JsonKey(name: 'stat')
  late BiliHotVideoStat stats;

  @JsonKey(name: 'rcmd_reason')
  late BiliHotVideoRecommendReason recommendReason;

  @JsonKey(ignore: true)
  bool isFavorite = false;

  @JsonKey(ignore: true)
  bool isLateSeeing = false;

  BiliHotVideo();

  factory BiliHotVideo.fromJson(Map<String, dynamic> json) => _$BiliHotVideoFromJson(json);

  Map<String, dynamic> toJson() => _$BiliHotVideoToJson(this);
}
