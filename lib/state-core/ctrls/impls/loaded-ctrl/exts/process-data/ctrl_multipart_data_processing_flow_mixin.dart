import 'package:redstonex/commons/exceptions/commons_app_exception.dart';
import 'package:redstonex/state-core/ctrls/definitions/loadable_view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/impls/loaded-ctrl/exts/load-data/ctrl_multipart_data_loading_flow_mixin.dart';

/// Ctrl process loaded data flow control.
///
/// `T` is data type of loading data from any where.
/// Any data type of secondary processing by the
/// user, it can be the same with `T`, so they do not
/// need to be processed again. Recommended practice
/// is to process them as the data structure of
/// the internal system.
///
/// Ctrl data process flow:
/// (1.)[onPreLoading] -> (2.)[CtrlMultipartDataLoadingFlowMixin.onFetchingData]
/// -> (3.)[onPostLoading] -> (4.)[onLoadingCompleted]
///
/// If you want catch error and exception, do something
/// in [CtrlMultipartDataLoadingFlowMixin.onLoadDataError] when process (2.).
/// Or do something in process (1.), process (3.), process (4.),
/// because data process flow will call [onLoadDataError].
///
mixin CtrlMultipartDataProcessingFlowMixin<T> on LoadableViewCtrl {
  /// Do something pre load data
  void onPreLoading() => {};

  /// Do something post load data
  void onPostLoading(List<T>? obtainedData) => {};

  /// Process loaded data
  void onLoadingCompleted(List<T>? obtainedData) => {};

  /// Process error or exception on process data
  void onProcessDataError(Object e, StackTrace s) => throw CommonException(e, s);
}
