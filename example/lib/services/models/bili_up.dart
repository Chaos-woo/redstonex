import 'package:json_annotation/json_annotation.dart';

part 'bili_up.g.dart';

@JsonSerializable()
class BiliUp {
  late int mid;
  late String name;
  late String face;

  BiliUp();

  factory BiliUp.fromJson(Map<String, dynamic> json) => _$BiliUpFromJson(json);

  Map<String, dynamic> toJson() => _$BiliUpToJson(this);
}
