import 'package:get/get.dart';

/// Definite view base properties.
abstract class ViewBaseProperties {
  /// for [GetBuilder]'s specify partial refresh
  String? viewBuilderId() => null;
}
