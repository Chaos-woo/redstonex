// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City()
  ..id = json['id'] as String
  ..provinceId = json['provinceId'] as String
  ..name = json['name'] as String;

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'provinceId': instance.provinceId,
      'name': instance.name,
    };
