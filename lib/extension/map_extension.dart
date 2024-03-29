
/// map类型扩展
extension ExtMap on Map<String, dynamic> {
  T getAs<T>(String key) {
    return this[key] as T;
  }

  T? getNullAs<T>(String key) {
    return containsKey(key) ? getAs<T>(key) : null;
  }
}