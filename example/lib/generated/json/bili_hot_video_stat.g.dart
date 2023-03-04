import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/bili_hot_video_stat.dart';

BiliHotVideoStat $BiliHotVideoStatFromJson(Map<String, dynamic> json) {
	final BiliHotVideoStat biliHotVideoStat = BiliHotVideoStat();
	final int? aid = jsonConvert.convert<int>(json['aid']);
	if (aid != null) {
		biliHotVideoStat.aid = aid;
	}
	final int? view = jsonConvert.convert<int>(json['view']);
	if (view != null) {
		biliHotVideoStat.view = view;
	}
	final int? danmaku = jsonConvert.convert<int>(json['danmaku']);
	if (danmaku != null) {
		biliHotVideoStat.danmaku = danmaku;
	}
	final int? reply = jsonConvert.convert<int>(json['reply']);
	if (reply != null) {
		biliHotVideoStat.reply = reply;
	}
	final int? favorite = jsonConvert.convert<int>(json['favorite']);
	if (favorite != null) {
		biliHotVideoStat.favorite = favorite;
	}
	final int? coin = jsonConvert.convert<int>(json['coin']);
	if (coin != null) {
		biliHotVideoStat.coin = coin;
	}
	final int? share = jsonConvert.convert<int>(json['share']);
	if (share != null) {
		biliHotVideoStat.share = share;
	}
	final int? like = jsonConvert.convert<int>(json['like']);
	if (like != null) {
		biliHotVideoStat.like = like;
	}
	return biliHotVideoStat;
}

Map<String, dynamic> $BiliHotVideoStatToJson(BiliHotVideoStat entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['aid'] = entity.aid;
	data['view'] = entity.view;
	data['danmaku'] = entity.danmaku;
	data['reply'] = entity.reply;
	data['favorite'] = entity.favorite;
	data['coin'] = entity.coin;
	data['share'] = entity.share;
	data['like'] = entity.like;
	return data;
}