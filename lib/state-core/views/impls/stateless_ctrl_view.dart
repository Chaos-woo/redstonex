import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:redstonex/state-core/views/definitions/view_base_properties.dart';
import 'package:redstonex/state-core/views/definitions/view_single_ctrl_get.dart';

/// Simple stateless ctrl view.
abstract class StatelessCtrlView<C extends GetxController> extends GetView<C>
    implements ViewSingleCtrlGet<C>, ViewBaseProperties {

  @mustCallSuper
  StatelessCtrlView({Key? key}) : super(key: key);

  /// first `build` method [BuildContext] params
  late BuildContext rootCxt;
  
  @override
  Widget build(BuildContext context) {
    rootCxt = context;
    metaCtrl = controller;
    return selfBuild();
  }

  /// Return self container view.
  Widget selfBuild();
}

