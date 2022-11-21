import 'dart:convert';

import 'package:redstonex/mvp/paging/paging_data.g.dart';

class PagingData<T> {
  /// 当前页
  int? current;
  List<T>? data;
  int? total;

  PagingData();

  factory PagingData.fromJson(Map<String, dynamic> json) => $PagingDataFromJson<T>(json);

  Map<String, dynamic> toJson() => $PagingDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
