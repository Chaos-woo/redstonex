part 'paging_data.g.dart';

class rPagingData<T> {
  /// 当前页
  int? currentIndex;
  List<T>? data;
  int? total;

  rPagingData();

  Map<String, dynamic> toJson() => _$PagingDataToJson(this);
}
