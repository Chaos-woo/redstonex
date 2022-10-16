import 'package:redstonex/state-core/ctrls/definitions/view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/definitions/view_ctrl_life_cycle.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/load-data/ctrl_single_data_loading_flow_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/process-data/ctrl_single_data_processing_flow_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/ctrl_status_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/single_data_view_ctrl.dart';

/// A loaded view ctrl.
///
/// Identify need loaded external data view ctrl.
/// Any class can inherit  it and implement method of the
/// [ViewCtrlLifeCycle] to do something. The processing
/// methods in its implementation class need to be
/// called step by step according to the loading stage
/// of data. Pay attention to the loading and processing
/// time of data when using.
///
/// It can be divided into the following scenario processing,
///   * [SingleDataViewCtrl]
///   * []
///   * []
///
/// It uses the following mixins to control the loading and
/// processing timing of data, as well as the current ctrl state:
///   * [CtrlSingleDataLoadingFlowMixin]
///   * [CtrlSingleDataProcessingFlowMixin]
///   * [CtrlStatusMixin]
///
/// It can be customized according to needs.
abstract class LoadableViewCtrl extends ViewCtrl {}
