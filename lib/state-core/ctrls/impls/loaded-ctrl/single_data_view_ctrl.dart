import 'package:flutter/foundation.dart';
import 'package:redstonex/state-core/ctrls/definitions/loadable_view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/ctrl_status_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/process-data/ctrl_single_data_processing_flow_mixin.dart';

import 'exts/load-data/ctrl_single_data_loading_flow_mixin.dart';

/// Single data view ctrl.
///
/// An object only can fetch data once.
///
abstract class SingleDataViewCtrl<T> extends LoadableViewCtrl
    with CtrlSingleDataLoadingFlowMixin<T>, CtrlSingleDataProcessingFlowMixin<T>, CtrlStatusMixin {
  /// `T` type of data obtained by the user
  T? _originalFetchedData;

  @override
  @mustCallSuper
  void onCtrlInitial() {
    initialCtrlStatus();
  }

  @override
  Future<void> onCtrlInitialReady() async {
    /// pre process before fetch data
    onPreLoading();

    T? fetchVal;
    try {
      fetchVal = await onFetchingData();
    } catch (e, s) {
      // maybe process exception when throw exception of loading data
      onLoadDataError(e, s);
    }

    /// save original fetched data
    _originalFetchedData = fetchVal;
    try {
      /// post process after fetch data
      onPostLoading(fetchVal);

      /// secondary process fetched data for the user
      onLoadingCompleted(fetchVal);
    } catch (e, s) {
      /// process exception when processing data
      onLoadingError(e, s);
    }
  }

  @override
  void onCtrlDispose() => {};

  /// Test code. Not recommended use.
  Future<void> testViewCtrlInitialReady() async {
    await onCtrlInitialReady();
  }
}
