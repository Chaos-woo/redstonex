import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ImageFormat { png, jpg, jpeg, gif, webp, bmp }

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp'][index];
}

class rImage {
  static final rImage _single = rImage._internal();

  rImage._internal();

  factory rImage() => _single;

  ImageProvider getAssetImageProvider(String path) {
    return AssetImage(path);
  }

  ImageProvider getHolderImageNetProvider(String? imageUrl, {String holderImg = ''}) {
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(holderImg);
    }
    return CachedNetworkImageProvider(imageUrl!);
  }
}
