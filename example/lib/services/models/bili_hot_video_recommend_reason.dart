import 'package:json_annotation/json_annotation.dart';

part 'bili_hot_video_recommend_reason.g.dart';

@JsonSerializable()
class BiliHotVideoRecommendReason {
  late String content;

  BiliHotVideoRecommendReason();

  factory BiliHotVideoRecommendReason.fromJson(Map<String, dynamic> json) => _$BiliHotVideoRecommendReasonFromJson(json);

  Map<String, dynamic> toJson() => _$BiliHotVideoRecommendReasonToJson(this);
}
