import 'package:json_annotation/json_annotation.dart';

part 'bili_hot_video_stat.g.dart';

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

  factory BiliHotVideoStat.fromJson(Map<String, dynamic> json) => _$BiliHotVideoStatFromJson(json);

  Map<String, dynamic> toJson() => _$BiliHotVideoStatToJson(this);
}