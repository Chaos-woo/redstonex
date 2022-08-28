import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:redstonex/commons/standards/refreshable_syntax.dart';
import 'package:redstonex/state-core/ctrls/definitions/loaded_view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/ctrl_status_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/load-data/ctrl_multipart_data_load_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/process-data/ctrl_multipart_data_process_mixin.dart';

/// Refreshable data view ctrl.
///
/// Ctrl will fetch data after initial ready, and
/// it can refresh all data in memory in every refresh
/// operation and should clear current [_obtainedData].
///
/// Note, if you want to load the large data, advising
/// do not use this.
///
abstract class RefreshableDataViewCtrl<T> extends LoadedViewCtrl
    with
        CtrlMultipartDataLoadMixin<T>,
        CtrlMultipartDataProcessMixin<T>,
        CtrlStatusMixin,
        RefreshableSyntax<T> {
  /// `T` type of data list obtained by the user
  List<T> _obtainedData = [];

  /// refresh controller
  RefreshController pull2refreshController = RefreshController(initialRefresh: false);

  /// refresh unique key, for exception of rebuild
  /// page or widget associated with the ctrl
  UniqueKey refreshSmarterKey = UniqueKey();

  @override
  @mustCallSuper
  void onViewCtrlInitial() {
    initialCtrlStatus();
  }

  /// Maybe using older [pull2refreshController] and [refreshSmarterKey],
  /// page or widget with [SmartRefresher] will display older data
  /// and not refresh new data.
  ///
  /// At present, the simple method is to use a new key to identify
  /// a new [SmartRefresher] component. Meaning directly rebuild
  /// [SmartRefresher] component.
  void solveRefreshAbnormal() {
    pull2refreshController = RefreshController(initialRefresh: false);
    refreshSmarterKey = UniqueKey();
  }

  @override
  Future<void> onViewCtrlInitialReady() async {
    /// only once
    onInitialReadyOnce();

    /// first load data
    await refresh();
  }

  /// Clean built-in obtained data before load of refresh
  void _cleanBuiltInObtainedData() => _obtainedData.clear();

  @override
  void onViewCtrlDispose() {
    pull2refreshController.dispose();
  }

  /// Only execute once in [onViewCtrlInitialReady], and it will
  /// not be executed after refresh operation
  void onInitialReadyOnce();

  @override
  Future<void> refresh() async {
    /// pre process load data
    onPreLoadData();

    /// initial or clean built-in data
    _cleanBuiltInObtainedData();

    List<T>? fetchVal;
    try {
      fetchVal = await onLoadData();
    } catch (e, s) {
      // maybe process exception when throw exception of loading data
      onLoadDataError(e, s);
    }

    /// save original obtained data
    _obtainedData = fetchVal ?? [];
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
}
