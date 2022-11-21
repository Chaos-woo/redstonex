import 'package:redstonex/generated/json/base/json_convert_content.dart';
import 'package:redstonex/mvp/paging/paging_data.dart';

PagingData<T> $PagingDataFromJson<T>(Map<String, dynamic> json) {
  final PagingData<T> pagingData = PagingData<T>();
  final int? current = jsonConvert.convert<int>(json['current']);
  if (current != null) {
    pagingData.current = current;
  }
  final List<T>? data = jsonConvert.convertListNotNull<T>(json['data']);
  if (data != null) {
    pagingData.data = data;
  }
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    pagingData.total = total;
  }
  return pagingData;
}

Map<String, dynamic> $PagingDataToJson(PagingData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['current'] = entity.current;
  data['data'] = entity.data;
  data['total'] = entity.total;
  return data;
}
