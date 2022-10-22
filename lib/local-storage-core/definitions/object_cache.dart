
/// object cache definition.
abstract class ObjectCache {
  R? read<R>(String key);

  void write<T>(String key, T value);

  void remove(String key);

  bool exist(String key);
}