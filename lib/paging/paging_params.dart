import 'dart:convert';

import 'package:redstonex/generated/json/base/json_field.dart';
import 'package:redstonex/generated/json/paging_params.g.dart';

@JsonSerializable()
class PagingParams {
  int currentIndex = 1;
  /// 额外请求参数
  Map<String, dynamic>? extra = {};
  /// 任意模型参数
  Map<String, dynamic> model = {};
  String? order = 'descending';
  int size = 10;
  String? sort = "id";

  @JSONField(serialize: false)
  int? total;

  PagingParams();

  factory PagingParams.fromJson(Map<String, dynamic> json) => $PagingParamsFromJson(json);

  Map<String, dynamic> toJson() => $PagingParamsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory PagingParams.create({
    required int pageIndex,
    int pageSize = 10,
    Map<String, dynamic>? model,
    Map<String, dynamic>? extra,
  }) {
    var request = PagingParams();
    request.currentIndex = pageIndex;
    request.size = pageSize;
    request.model = model ?? {};
    request.extra = extra ?? {};
    return request;
  }
}