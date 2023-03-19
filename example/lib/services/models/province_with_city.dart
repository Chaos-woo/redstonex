import 'package:example/services/models/city.dart';
import 'package:example/services/models/province.dart';
import 'package:example/services/models/with_city.dart';
import 'package:json_annotation/json_annotation.dart';

part 'province_with_city.g.dart';

@JsonSerializable()
class ProvinceWithCity {

	late String provinceId;
	late String provinceName;
	late List<WithCity> cities;
  
  ProvinceWithCity();

  factory ProvinceWithCity.fromJson(Map<String, dynamic> json) => _$ProvinceWithCityFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceWithCityToJson(this);

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