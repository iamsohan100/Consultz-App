import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:flutter/material.dart';

class DisplayNetworkImage extends StatelessWidget {
  const DisplayNetworkImage({
    super.key,
    required this.imageUrl,
    this.imageWidth,
    this.imageHeight,
    this.iconSize,
    this.imageFit,
    this.radius,
    this.imageSize = 0.0,
  });
  final double? radius;
  final String? imageUrl;
  final double? imageWidth;
  final double? imageHeight;
  final double? iconSize;
  final BoxFit? imageFit;
  final double imageSize;
  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cacheSize = ((imageWidth ?? imageSize) * pixelRatio).toInt();
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 6),
          image: DecorationImage(
            image: const AssetImage(AppImages.profileImage),
            fit: imageFit ?? BoxFit.cover,
          ),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      memCacheWidth: cacheSize,
      maxWidthDiskCache: cacheSize,
      imageBuilder: (context, imageProvider) => Container(
        width: imageWidth,
        height: imageHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 6),
          image: DecorationImage(
            image: imageProvider,
            fit: imageFit ?? BoxFit.contain,
          ),
        ),
      ),
      placeholder: (context, url) =>
          ShimmerLoading(width: imageWidth, height: imageHeight),
      errorWidget: (context, url, error) =>
          Image.asset(AppImages.profileImage, fit: BoxFit.cover),
    );
  }
}
