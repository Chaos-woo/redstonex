// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_with_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceWithCity _$ProvinceWithCityFromJson(Map<String, dynamic> json) =>
    ProvinceWithCity()
      ..provinceId = json['provinceId'] as String
      ..provinceName = json['provinceName'] as String
      ..cities = (json['cities'] as List<dynamic>)
          .map((e) => WithCity.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ProvinceWithCityToJson(ProvinceWithCity instance) =>
    <String, dynamic>{
      'provinceId': instance.provinceId,
      'provinceName': instance.provinceName,
      'cities': instance.cities,
    };
