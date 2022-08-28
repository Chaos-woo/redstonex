
import 'package:redstonex/state-core/ctrls/definitions/nonloaded_view_ctrl.dart';

/// A simple non loaded view ctrl implement.
/// Provide default life cycle method implement.
abstract class SimpleNonloadedViewCtrl extends NonloadedViewCtrl {
  @override
  void onViewCtrlInitial() => {};

  @override
  Future<void> onViewCtrlInitialReady() => Future.value();

  @override
  void onViewCtrlDispose() => {};

}