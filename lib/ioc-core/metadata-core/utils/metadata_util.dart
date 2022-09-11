
/// Reflectable metadata util.
///
class MetadataUtil {

  /// Whether is [targetMetadataType] of [metadata].
  static bool isTarget(Object metadata, Type targetMetadataType) {
    return metadata.runtimeType == targetMetadataType;
  }

  /// Whether exist [targetMetadataType] in [metadata] list.
  static bool existInList(List<Object> metadata, Type targetMetadataType) {
    return indexInList(metadata, targetMetadataType) > -1;
  }

  /// Return [targetMetadataType] index in [metadata] list
  static int indexInList(List<Object> metadata, Type targetMetadataType) {
    return metadata.indexWhere((ele) => isTarget(ele, targetMetadataType));
  }

  /// find carriers in [metadata] list.
  static S? findCarrier<S>(List<Object> metadata) {
    int index = indexInList(metadata, S.runtimeType);
    return index != -1 ? metadata[index] as S : null;
  }
}