import 'package:example/generated/json/base/json_field.dart';
import 'package:example/generated/json/province_with_city.g.dart';
import 'package:example/services/models/city.dart';
import 'dart:convert';

import 'package:example/services/models/province.dart';

@JsonSerializable()
class ProvinceWithCity {

	late String provinceId;
	late String provinceName;
	late List<WithCity> cities;
  
  ProvinceWithCity();

  factory ProvinceWithCity.fromJson(Map<String, dynamic> json) => $ProvinceWithCityFromJson(json);

  Map<String, dynamic> toJson() => $ProvinceWithCityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  Province getProvince() {
    Province p = Province();
    p.id = provinceId;
    p.name = provinceName;
    return p;
  }

  List<City> getCities() {
    return cities.map((v) {
      City c = City();
      c.provinceId = provinceId;
      c.id = v.cityId;
      c.name = v.cityName;
      return c;
    }).toList();
  }
}

@JsonSerializable()
class WithCity {

	late String cityId;
	late String cityName;
  
  WithCity();

  factory WithCity.fromJson(Map<String, dynamic> json) => $WithCityFromJson(json);

  Map<String, dynamic> toJson() => $WithCityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}