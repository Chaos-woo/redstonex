import 'package:redstonex/commons/exceptions/commons_app_exception.dart';
import 'package:redstonex/state-core/ctrls/definitions/loaded_view_ctrl.dart';

/// ctrl load data flow control
///
/// `T` is data type of loading data from any where.
mixin CtrlSingleDataLoadMixin<T> on LoadedViewCtrl {
  /// Load user business data after [LoadedViewCtrl] initial
  Future<T?> onLoadData();

  /// Process error or exception on loading data
  Future<T> onLoadDataError(Object e, StackTrace s) => throw CommonsAppException(e, s);
}
