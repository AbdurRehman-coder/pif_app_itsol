import 'package:disposable_cached_images/disposable_cached_images.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/widgets/nil.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    required this.image,
    super.key,
    this.fit,
    this.shape,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.filterQuality = FilterQuality.low,
    this.width,
    this.height,
    this.color,
    this.constraints,
    this.excludeFromSemantics = false,
    this.semanticLabel,
    this.placeholder,
    this.errorWidget,
  });

  final ImageProvider<Object> image;

  final BoxFit? fit;

  final BoxShape? shape;

  final BorderRadius? borderRadius;

  final Clip clipBehavior;

  final FilterQuality filterQuality;

  final double? width;

  final double? height;

  final Color? color;

  final BoxConstraints? constraints;

  final bool excludeFromSemantics;

  final String? semanticLabel;

  final Widget Function(BuildContext, String)? placeholder;

  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  @override
  Widget build(BuildContext context) {
    Widget? imgWidget;

    if (image is NetworkImage) {
      final cachedImage = image as NetworkImage;
      imgWidget = DisposableCachedImage.network(
        imageUrl: cachedImage.url,
        height: height,
        width: width,
        fit: fit,
        color: color,
        shape: shape ?? BoxShape.rectangle,
        borderRadius: borderRadius,
        filterQuality: filterQuality,
        keepAlive: true,
        keepBytesInMemory: false,
        onLoading: (context, height, width) {
          return placeholder?.call(context, '') ?? nil;
        },
        onError: (context, error, stackTrace, retryCall) {
          return errorWidget?.call(context, error.toString(), stackTrace) ?? nil;
        },
      );
    } else if (image is AssetImage) {
      imgWidget = Image.asset(
        (image as AssetImage).assetName,
        filterQuality: filterQuality,
        fit: fit,
        width: width,
        height: height,
        color: color,
      );
    } else if (image is MemoryImage) {
      imgWidget = Image.memory(
        (image as MemoryImage).bytes,
        filterQuality: filterQuality,
        fit: fit,
        width: width,
        height: height,
        color: color,
      );
    } else if (image is FileImage) {
      imgWidget = Image.file(
        (image as FileImage).file,
        filterQuality: filterQuality,
        fit: fit,
        width: width,
        height: height,
        color: color,
        cacheWidth: width?.toInt(),
        cacheHeight: height?.toInt(),
      );
    }

    if (shape != null) {
      switch (shape!) {
        case BoxShape.circle:
          imgWidget = ClipOval(
            clipBehavior: clipBehavior,
            child: imgWidget,
          );
          break;
        case BoxShape.rectangle:
          if (borderRadius != null) {
            imgWidget = ClipRRect(
              borderRadius: borderRadius,
              clipBehavior: clipBehavior,
              child: imgWidget,
            );
          }
      }
    }

    if (constraints != null) {
      imgWidget = ConstrainedBox(
        constraints: constraints!,
        child: imgWidget,
      );
    }

    if (excludeFromSemantics) {
      return imgWidget!;
    }
    return Semantics(
      container: semanticLabel != null,
      image: true,
      label: semanticLabel ?? '',
      child: imgWidget,
    );
  }
}
