/// A redstone dio option of creating.
///
/// it's properties will override global configuration
class RedStoneDioOption {
  /// auto insert log interceptor for dio
  bool? enableAutoLogInterceptor;

  /// whether enable publish loading event when http request
  bool? enableHttpLoadingEventPublish;

  /// enable request context log
  bool? enableRequestContextInterceptor;

  RedStoneDioOption({
    this.enableAutoLogInterceptor,
    this.enableHttpLoadingEventPublish,
    this.enableRequestContextInterceptor,
  });
}
