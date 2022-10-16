import 'package:redstonex/state-core/ctrls/definitions/view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/definitions/view_ctrl_life_cycle.dart';
import 'package:redstonex/state-core/ctrls/impls/nonloaded-ctrl/simple_nonloaded_view_ctrl.dart';

/// A non loaded view ctrl.
///
/// Identify non loaded external data view ctrl.
/// Any class can inherit  it and implement method of the
/// [ViewCtrlLifeCycle] to do something. Or
/// inheriting [SimpleNonloadedViewCtrl], because
/// it has implement unnecessary life method.
abstract class NonloadableViewCtrl extends ViewCtrl {}
