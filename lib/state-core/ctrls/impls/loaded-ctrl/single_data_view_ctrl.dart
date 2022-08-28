import 'package:flutter/foundation.dart';
import 'package:redstonex/state-core/ctrls/definitions/loaded_view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/ctrl_status_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/process-data/ctrl_single_data_process_mixin.dart';

import 'exts/load-data/ctrl_single_data_load_mixin.dart';

/// Single data view ctrl.
///
/// An object only can fetch data once.
///
abstract class SingleDataViewCtrl<T> extends LoadedViewCtrl
    with CtrlSingleDataLoadMixin<T>, CtrlSingleDataProcessMixin<T>, CtrlStatusMixin {
  /// `T` type of data obtained by the user
  T? _obtainedData;

  @override
  @mustCallSuper
  void onViewCtrlInitial() {
    initialCtrlStatus();
  }

  @override
  Future<void> onViewCtrlInitialReady() async {
    /// pre process load data
    onPreLoadData();

    T? fetchVal;
    try {
      fetchVal = await onLoadData();
    } catch (e, s) {
      // maybe process exception when throw exception of loading data
      onLoadDataError(e, s);
    }

    /// save original obtained data
    _obtainedData = fetchVal;
    try {
      /// post process load data
      onPostLoadData(fetchVal);

      /// secondary process obtained data for the user
      onCompletedLoadData(fetchVal);
    } catch (e, s) {
      /// process exception when processing data
      onProcessDataError(e, s);
    }
  }

  @override
  void onViewCtrlDispose() => {};

  /// Test code. Not recommended use.
  Future<void> testViewCtrlInitialReady() async {
    await onViewCtrlInitialReady();
  }
}
