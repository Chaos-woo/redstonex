import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/province.g.dart';
import 'dart:convert';

@JsonSerializable()
class Province {

	late String id;
	late String name;
  
  Province();

  factory Province.fromJson(Map<String, dynamic> json) => $ProvinceFromJson(json);

  Map<String, dynamic> toJson() => $ProvinceToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}