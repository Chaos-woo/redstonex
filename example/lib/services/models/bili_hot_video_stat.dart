import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/bili_hot_video_stat.g.dart';
import 'dart:convert';

@JsonSerializable()
class BiliHotVideoStat {

	late int aid;
	late int view;
	late int danmaku;
	late int reply;
	late int favorite;
	late int coin;
	late int share;
	late int like;
  
  BiliHotVideoStat();

  factory BiliHotVideoStat.fromJson(Map<String, dynamic> json) => $BiliHotVideoStatFromJson(json);

  Map<String, dynamic> toJson() => $BiliHotVideoStatToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}