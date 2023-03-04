import 'package:redstonex/generated/json/base/json_convert_content.dart';
import 'package:redstonex/paging/paging_data.dart';

PagingData<T> $PagingDataFromJson<T>(Map<String, dynamic> json) {
  final PagingData<T> pagingData = PagingData<T>();
  final int? currentIndex = jsonConvert.convert<int>(json['currentIndex']);
  if (currentIndex != null) {
    pagingData.currentIndex = currentIndex;
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
  data['currentIndex'] = entity.currentIndex;
  data['data'] = entity.data;
  data['total'] = entity.total;
  return data;
}
