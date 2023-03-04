import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/paging_bili_hot_video.dart';
import 'package:example/services/models/bili_hot_video.dart';


PagingBiliHotVideo $PagingBiliHotVideoFromJson(Map<String, dynamic> json) {
	final PagingBiliHotVideo pagingBiliHotVideo = PagingBiliHotVideo();
	final List<BiliHotVideo>? list = jsonConvert.convertListNotNull<BiliHotVideo>(json['list']);
	if (list != null) {
		pagingBiliHotVideo.list = list;
	}
	final bool? noMore = jsonConvert.convert<bool>(json['no_more']);
	if (noMore != null) {
		pagingBiliHotVideo.noMore = noMore;
	}
	return pagingBiliHotVideo;
}

Map<String, dynamic> $PagingBiliHotVideoToJson(PagingBiliHotVideo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['list'] =  entity.list.map((v) => v.toJson()).toList();
	data['no_more'] = entity.noMore;
	return data;
}