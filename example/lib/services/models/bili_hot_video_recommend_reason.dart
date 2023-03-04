import 'dart:convert';

import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/bili_hot_video_recommend_reason.g.dart';

@JsonSerializable()
class BiliHotVideoRecommendReason {
  late String content;

  BiliHotVideoRecommendReason();

  factory BiliHotVideoRecommendReason.fromJson(Map<String, dynamic> json) => $BiliHotVideoRecommendReasonFromJson(json);

  Map<String, dynamic> toJson() => $BiliHotVideoRecommendReasonToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
