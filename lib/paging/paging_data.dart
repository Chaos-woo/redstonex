part 'paging_data.g.dart';

class PagingData<T> {
  /// 当前页
  int? currentIndex;
  List<T>? data;
  int? total;

  PagingData();

  Map<String, dynamic> toJson() => _$PagingDataToJson(this);
}
