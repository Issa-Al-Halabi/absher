import 'package:absher/presentation/resources/assets_manager.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? placeHolderHeight;
  final double? width;
  final int? cacheWidth;
  final int? cacheHeight;
  final Color? color;
  final String? fallbackPlaceHolder;
  final bool removeOnDispose;

  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.placeHolderHeight,
    this.width,
    this.cacheHeight,
    this.cacheWidth,
    this.color,
    this.fallbackPlaceHolder,
    this.removeOnDispose = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl ?? '',
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      color: color,
      printError: false,
      cacheMaxAge: const Duration(days: 30),
      clearMemoryCacheWhenDispose: removeOnDispose,
      handleLoadingProgress: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExtendedImage(
                image: const AssetImage(ImageManager.appLogo),
                clearMemoryCacheWhenDispose: true,
                fit: BoxFit.contain,
              ),
            );
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExtendedImage(
                image: AssetImage(fallbackPlaceHolder ?? ImageManager.appLogo),
                clearMemoryCacheWhenDispose: true,
                fit: BoxFit.contain,
                color: color,
              ),
            );
        }
      },
    );
  }
}
