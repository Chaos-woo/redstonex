import 'raw_data.dart';

part 'api_response.g.dart';

class rApiResponse {
  int? code;
  String? message;
  late rRawData data;

  rApiResponse();

  factory rApiResponse.fromJson(Map<String, dynamic> json) => _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
