import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/bili_hot_video_recommend_reason.dart';

BiliHotVideoRecommendReason $BiliHotVideoRecommendReasonFromJson(Map<String, dynamic> json) {
	final BiliHotVideoRecommendReason biliHotVideoRecommendReason = BiliHotVideoRecommendReason();
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		biliHotVideoRecommendReason.content = content;
	}
	return biliHotVideoRecommendReason;
}

Map<String, dynamic> $BiliHotVideoRecommendReasonToJson(BiliHotVideoRecommendReason entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['content'] = entity.content;
	return data;
}