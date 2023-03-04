import 'dart:convert';

import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/paging_bili_hot_video.g.dart';
import 'package:example/services/models/bili_hot_video.dart';

@JsonSerializable()
class PagingBiliHotVideo {
  late List<BiliHotVideo> list;

  @JSONField(name: "no_more")
  late bool noMore;

  PagingBiliHotVideo();

  factory PagingBiliHotVideo.fromJson(Map<String, dynamic> json) => $PagingBiliHotVideoFromJson(json);

  Map<String, dynamic> toJson() => $PagingBiliHotVideoToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
