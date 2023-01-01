import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageUtils {
  static ImageProvider getAssetImageProvider(String path) {
    return AssetImage(path);
  }

  static String getImagePath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }

  static String getFullImgPath(String path, {ImageFormat format = ImageFormat.png}) {
    return 'name.${format.value}';
  }

  static ImageProvider getHolderImageNetProvider(String? imageUrl, {String holderImg = ''}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImagePath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl!);
  }
}

enum ImageFormat { png, jpg, jpeg, gif, webp }

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'jpeg', 'gif', 'webp'][index];
}
