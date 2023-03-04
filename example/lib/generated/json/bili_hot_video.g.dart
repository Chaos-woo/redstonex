import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/bili_hot_video.dart';
import 'package:example/services/models/bili_hot_video_recommend_reason.dart';

import 'package:example/services/models/bili_hot_video_stat.dart';

import 'package:example/services/models/bili_up.dart';


BiliHotVideo $BiliHotVideoFromJson(Map<String, dynamic> json) {
	final BiliHotVideo biliHotVideo = BiliHotVideo();
	final int? aid = jsonConvert.convert<int>(json['aid']);
	if (aid != null) {
		biliHotVideo.aid = aid;
	}
	final String? tagName = jsonConvert.convert<String>(json['tname']);
	if (tagName != null) {
		biliHotVideo.tagName = tagName;
	}
	final String? pic = jsonConvert.convert<String>(json['pic']);
	if (pic != null) {
		biliHotVideo.pic = pic;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		biliHotVideo.title = title;
	}
	final int? pubDate = jsonConvert.convert<int>(json['pubdate']);
	if (pubDate != null) {
		biliHotVideo.pubDate = pubDate;
	}
	final String? shortLink = jsonConvert.convert<String>(json['short_link']);
	if (shortLink != null) {
		biliHotVideo.shortLink = shortLink;
	}
	final String? bVid = jsonConvert.convert<String>(json['bvid']);
	if (bVid != null) {
		biliHotVideo.bVid = bVid;
	}
	final BiliUp? owner = jsonConvert.convert<BiliUp>(json['owner']);
	if (owner != null) {
		biliHotVideo.owner = owner;
	}
	final BiliHotVideoStat? stats = jsonConvert.convert<BiliHotVideoStat>(json['stat']);
	if (stats != null) {
		biliHotVideo.stats = stats;
	}
	final BiliHotVideoRecommendReason? recommendReason = jsonConvert.convert<BiliHotVideoRecommendReason>(json['rcmd_reason']);
	if (recommendReason != null) {
		biliHotVideo.recommendReason = recommendReason;
	}
	return biliHotVideo;
}

Map<String, dynamic> $BiliHotVideoToJson(BiliHotVideo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['aid'] = entity.aid;
	data['tname'] = entity.tagName;
	data['pic'] = entity.pic;
	data['title'] = entity.title;
	data['pubdate'] = entity.pubDate;
	data['short_link'] = entity.shortLink;
	data['bvid'] = entity.bVid;
	data['owner'] = entity.owner.toJson();
	data['stat'] = entity.stats.toJson();
	data['rcmd_reason'] = entity.recommendReason.toJson();
	return data;
}