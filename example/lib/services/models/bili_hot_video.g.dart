// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bili_hot_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiliHotVideo _$BiliHotVideoFromJson(Map<String, dynamic> json) => BiliHotVideo()
  ..aid = json['aid'] as int
  ..tagName = json['tname'] as String
  ..pic = json['pic'] as String
  ..title = json['title'] as String
  ..pubDate = json['pubdate'] as int
  ..shortLink = json['short_link_v2'] as String
  ..bVid = json['bvid'] as String
  ..owner = BiliUp.fromJson(json['owner'] as Map<String, dynamic>)
  ..stats = BiliHotVideoStat.fromJson(json['stat'] as Map<String, dynamic>)
  ..recommendReason = BiliHotVideoRecommendReason.fromJson(
      json['rcmd_reason'] as Map<String, dynamic>);

Map<String, dynamic> _$BiliHotVideoToJson(BiliHotVideo instance) =>
    <String, dynamic>{
      'aid': instance.aid,
      'tname': instance.tagName,
      'pic': instance.pic,
      'title': instance.title,
      'pubdate': instance.pubDate,
      'short_link_v2': instance.shortLink,
      'bvid': instance.bVid,
      'owner': instance.owner,
      'stat': instance.stats,
      'rcmd_reason': instance.recommendReason,
    };
