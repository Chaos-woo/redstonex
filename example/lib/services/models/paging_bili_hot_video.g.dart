// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_bili_hot_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagingBiliHotVideo _$PagingBiliHotVideoFromJson(Map<String, dynamic> json) =>
    PagingBiliHotVideo()
      ..list = (json['list'] as List<dynamic>)
          .map((e) => BiliHotVideo.fromJson(e as Map<String, dynamic>))
          .toList()
      ..noMore = json['noMore'] as bool;

Map<String, dynamic> _$PagingBiliHotVideoToJson(PagingBiliHotVideo instance) =>
    <String, dynamic>{
      'list': instance.list,
      'noMore': instance.noMore,
    };
