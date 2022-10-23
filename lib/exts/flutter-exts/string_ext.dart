extension StringExt on String {
  DateTime get datetime => DateTime.parse(this);

  DateTime? get tryDatetime => DateTime.tryParse(this);
}
