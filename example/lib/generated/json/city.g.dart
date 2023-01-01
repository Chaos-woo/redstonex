import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/city.dart';

City $CityFromJson(Map<String, dynamic> json) {
	final City city = City();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		city.id = id;
	}
	final String? provinceId = jsonConvert.convert<String>(json['provinceId']);
	if (provinceId != null) {
		city.provinceId = provinceId;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		city.name = name;
	}
	return city;
}

Map<String, dynamic> $CityToJson(City entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['provinceId'] = entity.provinceId;
	data['name'] = entity.name;
	return data;
}