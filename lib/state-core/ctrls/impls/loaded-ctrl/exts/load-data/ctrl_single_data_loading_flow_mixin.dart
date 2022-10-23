import 'package:redstonex/exceptions/error_stack.dart';
import 'package:redstonex/state-core/ctrls/definitions/loadable_view_ctrl.dart';

/// ctrl load data flow control
///
/// `T` is data type of loading data from any where.
mixin CtrlSingleDataLoadingFlowMixin<T> on LoadableViewCtrl {
  /// Load user business data after [LoadableViewCtrl] initial
  Future<T?> onFetchingData();

  /// Process error or exception on loading data
  Future<T> onLoadDataError(Object e, StackTrace s) => throw ErrorStack(e, s);
}
