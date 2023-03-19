// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(
    Map<String, dynamic> json) =>
    ApiResponse()
    ..code = json['code'] as int?
    ..message = json['message'] as String?
    ..data = (RawData()..value = json['data']);

Map<String, dynamic> _$ApiResponseToJson(
    ApiResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };