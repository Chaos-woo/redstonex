import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 图片加载（支持本地与网络图片）
class RsxImageLoader extends StatelessWidget {
  const RsxImageLoader(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
    this.holderImg = '',
    this.errorImg = '',
    this.cacheWidth,
    this.cacheHeight,
    this.netImgProgressIndicatorBuilder,
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String holderImg;
  final String errorImg;
  final int? cacheWidth;
  final int? cacheHeight;
  final ProgressIndicatorBuilder? netImgProgressIndicatorBuilder;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty || image.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: image,
        placeholder: holderImg.isNotEmpty ? (_, __) => LocalAssetImageLoader(holderImg, height: height, width: width, fit: fit) : null,
        errorWidget: errorImg.isNotEmpty
            ? (_, __, dynamic error) => LocalAssetImageLoader(holderImg, height: height, width: width, fit: fit)
            : holderImg.isNotEmpty
                ? (_, __, dynamic error) => LocalAssetImageLoader(holderImg, height: height, width: width, fit: fit)
                : null,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
        progressIndicatorBuilder: netImgProgressIndicatorBuilder,
      );
    } else {
      return LocalAssetImageLoader(
        image,
        height: height,
        width: width,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }
  }
}

/// 本地图片加载
class LocalAssetImageLoader extends StatelessWidget {
  const LocalAssetImageLoader(
    this.image, {
    Key? key,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.color,
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,

      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}
