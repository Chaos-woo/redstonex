// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

rApiResponse _$ApiResponseFromJson(
    Map<String, dynamic> json) =>
    rApiResponse()
    ..code = json['code'] as int?
    ..message = json['message'] as String?
    ..data = (rRawData()..value = json['data']);

Map<String, dynamic> _$ApiResponseToJson(
    rApiResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };