// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Example _$ExampleFromJson(Map<String, dynamic> json) => Example(
      json['content'] as String,
      json['remark'] as String?,
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ExampleToJson(Example instance) => <String, dynamic>{
      'content': instance.content,
      'remark': instance.remark,
      'createdAt': instance.createdAt.toIso8601String(),
    };
