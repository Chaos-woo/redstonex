// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bili_hot_video_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiliHotVideoStat _$BiliHotVideoStatFromJson(Map<String, dynamic> json) =>
    BiliHotVideoStat()
      ..aid = json['aid'] as int
      ..view = json['view'] as int
      ..danmaku = json['danmaku'] as int
      ..reply = json['reply'] as int
      ..favorite = json['favorite'] as int
      ..coin = json['coin'] as int
      ..share = json['share'] as int
      ..like = json['like'] as int;

Map<String, dynamic> _$BiliHotVideoStatToJson(BiliHotVideoStat instance) =>
    <String, dynamic>{
      'aid': instance.aid,
      'view': instance.view,
      'danmaku': instance.danmaku,
      'reply': instance.reply,
      'favorite': instance.favorite,
      'coin': instance.coin,
      'share': instance.share,
      'like': instance.like,
    };
