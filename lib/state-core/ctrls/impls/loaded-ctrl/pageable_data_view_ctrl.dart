import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:redstonex/std-core/load_more_syntax.dart';
import 'package:redstonex/std-core/refreshable_syntax.dart';
import 'package:redstonex/state-core/ctrls/definitions/loadable_view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/ctrl_status_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/load-data/ctrl_multipart_data_loading_flow_mixin.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/process-data/ctrl_multipart_data_processing_flow_mixin.dart';

/// Refreshable data view ctrl.
///
/// Ctrl will fetch data after initial ready, and
/// it can refresh all data in memory in every refresh
/// operation and should clear current [_originalFetchedData].
///
/// Note, if you want to load the large data, advising
/// do not use this.
///
abstract class PageableDataViewCtrl<T> extends LoadableViewCtrl
    with
        CtrlMultipartDataLoadingFlowMixin<T>,
        CtrlMultipartDataProcessingFlowMixin<T>,
        CtrlStatusMixin,
        RefreshableSyntax<T>,
        LoadMoreSyntax<T> {
  /// `T` type of data list obtained by the user
  List<T> _originalFetchedData = [];

  /// refresh controller
  RefreshController pull2refreshController = RefreshController(initialRefresh: false);

  /// refresh unique key, for exception of rebuild
  /// page or widget associated with the ctrl
  UniqueKey refreshSmarterKey = UniqueKey();

  /// current page, recommend not process for subclass
  int _currentPage = 1;

  /// limit of per load.
  /// if modify [pagingLimit], plz override this method
  int get pagingLimit => 20;

  @override
  @mustCallSuper
  void onCtrlInitial() {
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
  Future<void> onCtrlInitialReady() async {
    /// pre process load data
    onPreLoading();

    /// initial or clear memory data
    _clearFetchedData();

    List<T>? fetchVal;
    try {
      fetchVal = await onFetchingData();
    } catch (e, s) {
      // maybe process exception when throw exception of loading data
      onLoadDataError(e, s);
    }

    /// save original obtained data
    _originalFetchedData = fetchVal ?? [];
    try {
      /// post process load data
      onPostLoading(fetchVal);

      /// secondary process obtained data for the user
      onLoadingCompleted(fetchVal);
    } catch (e, s) {
      /// process exception when processing data
      onProcessDataError(e, s);
    }
  }

  /// Clear fetched data before load of refresh
  void _clearFetchedData() => _originalFetchedData.clear();

  @override
  void onCtrlDispose() {
    pull2refreshController.dispose();
  }
}
