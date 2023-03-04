import 'dart:convert';

import 'package:redstonex/networks/response/api_response.g.dart';

class ApiResponse<T> {
  int? code;
  String? message;
  T? data;

  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json) => $ApiResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => $ApiResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
