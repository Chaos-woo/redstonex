import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/province_with_city.dart';
import 'package:example/services/models/city.dart';

import 'package:example/services/models/province.dart';


ProvinceWithCity $ProvinceWithCityFromJson(Map<String, dynamic> json) {
	final ProvinceWithCity provinceWithCity = ProvinceWithCity();
	final String? provinceId = jsonConvert.convert<String>(json['provinceId']);
	if (provinceId != null) {
		provinceWithCity.provinceId = provinceId;
	}
	final String? provinceName = jsonConvert.convert<String>(json['provinceName']);
	if (provinceName != null) {
		provinceWithCity.provinceName = provinceName;
	}
	final List<WithCity>? cities = jsonConvert.convertListNotNull<WithCity>(json['cities']);
	if (cities != null) {
		provinceWithCity.cities = cities;
	}
	return provinceWithCity;
}

Map<String, dynamic> $ProvinceWithCityToJson(ProvinceWithCity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['provinceId'] = entity.provinceId;
	data['provinceName'] = entity.provinceName;
	data['cities'] =  entity.cities.map((v) => v.toJson()).toList();
	return data;
}

WithCity $WithCityFromJson(Map<String, dynamic> json) {
	final WithCity withCity = WithCity();
	final String? cityId = jsonConvert.convert<String>(json['cityId']);
	if (cityId != null) {
		withCity.cityId = cityId;
	}
	final String? cityName = jsonConvert.convert<String>(json['cityName']);
	if (cityName != null) {
		withCity.cityName = cityName;
	}
	return withCity;
}

Map<String, dynamic> $WithCityToJson(WithCity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cityId'] = entity.cityId;
	data['cityName'] = entity.cityName;
	return data;
}