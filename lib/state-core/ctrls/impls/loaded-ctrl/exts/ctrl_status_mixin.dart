import 'package:redstonex/state-core/ctrls/definitions/loadable_view_ctrl.dart';
import 'package:redstonex/state-core/ctrls/models/ctrl_status.dart';

/// Provide [LoadableViewCtrl] running status of data,
/// for example, empty, loading, error, etc.
///
mixin CtrlStatusMixin on LoadableViewCtrl {
  CtrlStatus? _status;

  /// Initial ctrl status
  void initialCtrlStatus() {
    _status = CtrlStatus.empty();
  }
}

/// 控制器数据初始化 - user
///  -- state --
/// 网络检查 - def
///  -- state --
/// 数据预处理 - user
/// 获取数据 - user
///  -- state --
/// 数据二次处理 - user
///  -- state --
///
/// 异常流
///  -- state --
///
