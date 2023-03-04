import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/bili_up.dart';

BiliUp $BiliUpFromJson(Map<String, dynamic> json) {
	final BiliUp biliUp = BiliUp();
	final int? mid = jsonConvert.convert<int>(json['mid']);
	if (mid != null) {
		biliUp.mid = mid;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		biliUp.name = name;
	}
	final String? face = jsonConvert.convert<String>(json['face']);
	if (face != null) {
		biliUp.face = face;
	}
	return biliUp;
}

Map<String, dynamic> $BiliUpToJson(BiliUp entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['mid'] = entity.mid;
	data['name'] = entity.name;
	data['face'] = entity.face;
	return data;
}