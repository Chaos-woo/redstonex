import 'dart:convert';

import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/bili_up.g.dart';

@JsonSerializable()
class BiliUp {
  late int mid;
  late String name;
  late String face;

  BiliUp();

  factory BiliUp.fromJson(Map<String, dynamic> json) => $BiliUpFromJson(json);

  Map<String, dynamic> toJson() => $BiliUpToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
