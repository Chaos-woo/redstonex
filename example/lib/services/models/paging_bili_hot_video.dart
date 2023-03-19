import 'package:example/services/models/bili_hot_video.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paging_bili_hot_video.g.dart';

@JsonSerializable()
class PagingBiliHotVideo {
  late List<BiliHotVideo> list;
  late bool noMore;

  PagingBiliHotVideo();

  factory PagingBiliHotVideo.fromJson(Map<String, dynamic> json) => _$PagingBiliHotVideoFromJson(json);

  Map<String, dynamic> toJson() => _$PagingBiliHotVideoToJson(this);
}
