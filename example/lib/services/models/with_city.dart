import 'package:json_annotation/json_annotation.dart';

part 'with_city.g.dart';

@JsonSerializable()
class WithCity {

  late String cityId;
  late String cityName;

  WithCity();

  factory WithCity.fromJson(Map<String, dynamic> json) => _$WithCityFromJson(json);

  Map<String, dynamic> toJson() => _$WithCityToJson(this);
}