import 'dart:convert';

import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/bili_hot_video.g.dart';
import 'package:example/services/models/bili_hot_video_recommend_reason.dart';
import 'package:example/services/models/bili_hot_video_stat.dart';
import 'package:example/services/models/bili_up.dart';

@JsonSerializable()
class BiliHotVideo {
  late int aid;
  @JSONField(name: "tname")
  late String tagName;
  late String pic;
  late String title;
  @JSONField(name: "pubdate")
  late int pubDate;
  @JSONField(name: "short_link")
  late String shortLink;
  @JSONField(name: "bvid")
  late String bVid;
  late BiliUp owner;
  @JSONField(name: 'stat')
  late BiliHotVideoStat stats;
  @JSONField(name: 'rcmd_reason')
  late BiliHotVideoRecommendReason recommendReason;

  bool isFavorite = false;
  bool isLateSeeing = false;

  BiliHotVideo();

  factory BiliHotVideo.fromJson(Map<String, dynamic> json) => $BiliHotVideoFromJson(json);

  Map<String, dynamic> toJson() => $BiliHotVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
