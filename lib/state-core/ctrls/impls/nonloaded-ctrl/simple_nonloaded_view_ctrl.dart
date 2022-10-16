
import 'package:redstonex/state-core/ctrls/definitions/nonloadable_view_ctrl.dart';

/// A simple non loaded view ctrl implement.
/// Provide default life cycle method implement.
abstract class SimpleNonloadedViewCtrl extends NonloadableViewCtrl {
  @override
  void onCtrlInitial() => {};

  @override
  Future<void> onCtrlInitialReady() => Future.value();

  @override
  void onCtrlDispose() => {};

}