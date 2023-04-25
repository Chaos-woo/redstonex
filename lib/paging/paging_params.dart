import 'package:json_annotation/json_annotation.dart';

part 'paging_params.g.dart';

@JsonSerializable()
class PagingParams {
  int size = 10;
  int currentIndex = 1;
  /// 额外请求参数
  Map<String, dynamic>? extra = {};
  /// 任意模型参数
  Map<String, dynamic> model = {};

  int? total;

  PagingParams();

  factory PagingParams.fromJson(Map<String, dynamic> json) => _$PagingParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PagingParamsToJson(this);

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