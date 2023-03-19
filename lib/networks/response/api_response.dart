import 'package:redstonex/networks/response/raw_data.dart';

part 'api_response.g.dart';

class ApiResponse {
  int? code;
  String? message;
  late RawData data;

  ApiResponse();

  factory ApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
