import 'package:redstonex/state-core/ctrls/definitions/view_ctrl.dart';

/// Define [ViewCtrl] base life cycle.
///
abstract class ViewCtrlLifeCycle {
  /// Called immediately after the widget is allocated in memory.
  /// You might use this to initialize something for the controller.
  void onViewCtrlInitial();

  /// Called 1 frame after onViewCtrlInitial(). It is the perfect place to enter
  /// navigation events, like snackbar, dialogs, or a new route, or
  /// async request.
  Future<void> onViewCtrlInitialReady();

  /// Called before ctrl deleted. [onViewCtrlDispose] might be used to
  /// dispose resources used by the controller. Like closing events,
  /// or streams before the controller is destroyed.
  /// Or dispose objects that can potentially create some memory leaks,
  /// like TextEditingControllers, AnimationControllers.
  /// Might be useful as well to persist some data on disk.
  void onViewCtrlDispose();
}
