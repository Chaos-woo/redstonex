import 'package:json_annotation/json_annotation.dart';

part 'paging_params.g.dart';

@JsonSerializable()
class rPagingParams {
  int size = 10;
  int currentIndex = 1;
  /// 额外请求参数
  Map<String, dynamic>? extra = {};
  /// 任意模型参数
  Map<String, dynamic> model = {};

  int? total;

  rPagingParams();

  factory rPagingParams.fromJson(Map<String, dynamic> json) => _$PagingParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PagingParamsToJson(this);

  factory rPagingParams.create({
    required int pageIndex,
    int pageSize = 10,
    Map<String, dynamic>? model,
    Map<String, dynamic>? extra,
  }) {
    var request = rPagingParams();
    request.currentIndex = pageIndex;
    request.size = pageSize;
    request.model = model ?? {};
    request.extra = extra ?? {};
    return request;
  }
}