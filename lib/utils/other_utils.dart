import 'package:common_utils/common_utils.dart';

class XUtil {
  static final XUtil _single = XUtil._internal();

  XUtil._internal();

  factory XUtil() => _single;

  String formatPrice(String price, {MoneyFormat format = MoneyFormat.END_INTEGER}) {
    return MoneyUtil.changeYWithUnit(NumUtil.getDoubleByValueStr(price) ?? 0, MoneyUnit.YUAN, format: format);
  }
}
