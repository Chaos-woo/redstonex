
/// Reflectable metadata util.
class MetadataUtils {

  /// Whether is [targetMetadataType] of [metadata].
  static bool isTarget(Object metadata, Type targetMetadataType) {
    return metadata.runtimeType == targetMetadataType;
  }

  /// Whether exist [targetMetadataType] in [metadata] list.
  static bool exist(List<Object> metadata, Type targetMetadataType) {
    return indexOf(metadata, targetMetadataType) > -1;
  }

  /// Return [targetMetadataType] index in [metadata] list
  static int indexOf(List<Object> metadata, Type targetMetadataType) {
    return metadata.indexWhere((ele) => isTarget(ele, targetMetadataType));
  }

  /// find S type metadata in [metadata] list.
  static S? findMetadata<S>(List<Object> metadata) {
    int index = indexOf(metadata, S);
    return index != -1 ? metadata[index] as S : null;
  }
}