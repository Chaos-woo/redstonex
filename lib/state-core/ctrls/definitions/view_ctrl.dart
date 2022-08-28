import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:redstonex/state-core/ctrls/definitions/view_ctrl_life_cycle.dart';
import 'package:redstonex/state-core/ctrls/definitions/loaded_view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/definitions/nonloaded_view_ctrl.dart';

/// Define view ctrl basic information.
///
/// Base ctrl of view, Its subclasses are those
/// that need to load external data. The other is
/// that there is no need to load data from the
/// outside, and the internal variables determine
/// the relevant data fields when encoding.
///
/// See also:
///   * [LoadedViewCtrl] is a related to [CtrlStatus]
///   base ctrl class, so it can load data from any where
///   and change it status. When initializing, it needs to
///   obtain the required data from the outside,
///   conduct secondary processing, and then carry out
///   relevant logic processing and page display.
///   * [NonloadedViewCtrl] is a no need to load
///   data from the outside base ctrl class. It mainly
///   carries out relevant logic processing according
///   to the initial parameters.
///
abstract class ViewCtrl extends GetxController implements ViewCtrlLifeCycle {

  /// Called immediately after the widget is allocated in memory.
  /// You might use this to initialize something for the controller.
  @override
  void onInit() {
    super.onInit();
    onViewCtrlInitial();
  }

  /// Called 1 frame after onInit(). It is the perfect place to enter
  /// navigation events, like snackbar, dialogs, or a new route, or
  /// async request.
  @override
  void onReady() async {
    super.onReady();
    await onViewCtrlInitialReady();
  }

  /// Called before [onDelete] method. [onClose] might be used to
  /// dispose resources used by the controller. Like closing events,
  /// or streams before the controller is destroyed.
  /// Or dispose objects that can potentially create some memory leaks,
  /// like TextEditingControllers, AnimationControllers.
  /// Might be useful as well to persist some data on disk.
  @override
  void onClose() {
    onViewCtrlDispose();
    super.onClose();
  }
}
