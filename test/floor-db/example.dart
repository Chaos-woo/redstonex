import 'package:json_annotation/json_annotation.dart';
import 'package:redstonex/std-core/to_entity_syntax.dart';

import 'example_entity.dart';

part 'example.g.dart';

@JsonSerializable()
class Example with ToEntitySyntax<ExampleEntity> {
  /// example content
  String content;

  /// remark
  String? remark;

  /// created time
  // @JsonKey(fromJson: _dateTimeFromEpochUs, toJson: _dateTimeToEpochUs)
  DateTime createdAt;

  Example(this.content, this.remark, this.createdAt);

  factory Example.fromJson(Map<String, dynamic> json) => _$ExampleFromJson(json);

  Map<String, dynamic> toJson() => _$ExampleToJson(this);

  /// example
  static DateTime _dateTimeFromEpochUs(int us) => DateTime.fromMicrosecondsSinceEpoch(us);

  /// example
  static int? _dateTimeToEpochUs(DateTime? dateTime) => dateTime?.microsecondsSinceEpoch;

  @override
  ExampleEntity toEntity() {
    return ExampleEntity(content, remark);
  }
}
