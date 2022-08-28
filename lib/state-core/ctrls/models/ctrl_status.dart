
import 'package:get/get.dart';

/// Ctrl status.
///
/// See also [RxStatus]
class CtrlStatus {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isEmpty;
  final bool isLoadingMore;
  final Exception? exception;
  final String? errorMessage;

  CtrlStatus._({
    this.isEmpty = false,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.isLoadingMore = false,
    this.exception,
    this.errorMessage,
  });

  factory CtrlStatus.loading() {
    return CtrlStatus._(isLoading: true);
  }

  factory CtrlStatus.loadingMore() {
    return CtrlStatus._(isSuccess: true, isLoadingMore: true);
  }

  factory CtrlStatus.success() {
    return CtrlStatus._(isSuccess: true);
  }

  factory CtrlStatus.error([Exception? exception, String? message]) {
    return CtrlStatus._(isError: true, exception: exception, errorMessage: message);
  }

  factory CtrlStatus.empty() {
    return CtrlStatus._(isEmpty: true);
  }

}