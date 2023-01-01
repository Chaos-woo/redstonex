import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/city.g.dart';
import 'dart:convert';

@JsonSerializable()
class City {

	late String id;
	late String provinceId;
	late String name;
  
  City();

  factory City.fromJson(Map<String, dynamic> json) => $CityFromJson(json);

  Map<String, dynamic> toJson() => $CityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}