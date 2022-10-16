import 'package:redstonex/commons/exceptions/commons_app_exception.dart';
import 'package:redstonex/state-core/ctrls/definitions/loadable_view_ctrl.dart';

/// ctrl load data flow control
///
/// `T` is data type of loading data from any where.
mixin CtrlMultipartDataLoadingFlowMixin<T> on LoadableViewCtrl {
  /// Load user business data after [LoadableViewCtrl] initial
  Future<List<T>?> onFetchingData();

  /// Process error or exception on loading data
  Future<List<T>> onLoadDataError(Object e, StackTrace s) => throw CommonException(e, s);
}
