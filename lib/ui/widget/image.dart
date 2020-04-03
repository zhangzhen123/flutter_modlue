import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lmlive/config/resource_mananger.dart';

///这里说明下 为什么使用cached_network_image 虽然官方自带的image可以缓存图片 但是只是内存缓存 并没有进行硬盘缓存 而这里的cached_network_image就是对image的补充完善
enum ImageType {
  normal,
//  random, //随机
  assets, //资源目录
}

class WrapperImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageType imageType;

  WrapperImage(
      {@required this.url,
      @required this.width,
      @required this.height,
      this.imageType: ImageType.normal,
      this.fit: BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (_, __) =>
          ImageHelper.placeHolder(width: width, height: height),
      errorWidget: (_, __, ___) =>
          ImageHelper.error(width: width, height: height),
      fit: fit,
    );
  }

  String get imageUrl {
    switch (imageType) {
//      case ImageType.random:
//        return ImageHelper.randomUrl(
//            key: url, width: width.toInt(), height: height.toInt());
      case ImageType.assets:
        return ImageHelper.wrapAssets(url);
      case ImageType.normal:
        return url;
    }
    return url;
  }
}
