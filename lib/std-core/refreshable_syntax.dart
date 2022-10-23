/// Define [refresh] method stand syntax.
///
/// Load data of type `E`.
mixin RefreshableSyntax<E> {
  Future<void> refresh();
}
