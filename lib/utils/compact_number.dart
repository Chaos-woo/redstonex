import 'package:number_display/number_display.dart';

class rCompactNumber {
  static final rCompactNumber _single = rCompactNumber._internal();
  static final _innerCompactDisplay = createDisplay();

  rCompactNumber._internal();

  factory rCompactNumber() => _single;

  Display customDisplayConfig({
    int length = 9,
    int? decimal,
    String placeholder = '',
    String? separator = ',',
    String? decimalPoint = '.',
    RoundingType roundingType = RoundingType.round,
    List<String> units = const ['k', 'M', 'G', 'T', 'P'],
  }) {
    return createDisplay(
      length: length,
      decimal: decimal,
      placeholder: placeholder,
      separator: separator,
      decimalPoint: decimalPoint,
      roundingType: roundingType,
      units: units,
    );
  }

  String compact(num number, {Display? customDisplayConfig}) {
    return (null == customDisplayConfig ? _innerCompactDisplay(number) : customDisplayConfig(number));
  }

  String stringCompact(String numberSource, {int? radix, Display? customDisplayConfig}) {
    int? number = int.tryParse(numberSource, radix: radix);
    return (null == customDisplayConfig ? _innerCompactDisplay(number) : customDisplayConfig(number));
  }
}
