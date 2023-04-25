// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagingParams _$PagingParamsFromJson(Map<String, dynamic> json) => PagingParams()
  ..currentIndex = json['currentIndex'] as int
  ..extra = json['extra'] as Map<String, dynamic>?
  ..model = json['model'] as Map<String, dynamic>
  ..size = json['size'] as int
  ..total = json['total'] as int?;

Map<String, dynamic> _$PagingParamsToJson(PagingParams instance) =>
    <String, dynamic>{
      'currentIndex': instance.currentIndex,
      'extra': instance.extra,
      'model': instance.model,
      'size': instance.size,
      'total': instance.total,
    };
