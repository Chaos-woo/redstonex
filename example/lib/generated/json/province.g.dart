import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/services/models/province.dart';

Province $ProvinceFromJson(Map<String, dynamic> json) {
	final Province province = Province();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		province.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		province.name = name;
	}
	return province;
}

Map<String, dynamic> $ProvinceToJson(Province entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	return data;
}