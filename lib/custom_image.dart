/// This library contains the [CustomImage] widget, which is used to display images
/// from various sources including the internet, assets, or files.
library custom_image;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Enum to specify the type of image source.
enum ImageType {
  /// Image is loaded from a file.
  file,

  /// Image is loaded from a network URL.
  network,

  /// Image is loaded from an asset.
  asset
}

/// A customizable widget for displaying images from various sources.
class CustomImage extends StatelessWidget {
  /// Callback function for when the image is tapped.
  final void Function()? onTap;

  /// Path or URL for the image.
  final String image;

  /// Theme settings for SVG images.
  final SvgTheme? svgTheme;

  /// How the image should be inscribed into the space allocated during layout.
  final BoxFit? fit;

  /// The height of the image.
  final double? height;

  /// The width of the image.
  final double? width;

  /// The color to apply to the image.
  final Color? color;

  /// Whether to display an elevation effect.
  final bool? elevation;

  /// List<BoxShadow>? boxShadow
  final List<BoxShadow>? boxShadow;

  /// The border radius of the image.
  final BorderRadius? borderRadius;

  /// The type of the image source.
  final ImageType? type;

  /// The quality of the image filter.
  final FilterQuality? filterQuality;

  /// The path to the image to be displayed if the main image fails to load.
  final String? pathNoImage;

  /// The widget to be displayed if the main image fails to load.
  final Widget? childNoImage;

  /// The path to the image to be displayed while the main image is loading.
  final String? pathLoading;

  /// The widget to be displayed while the main image is loading.
  final Widget? childLoading;

  /// The size of the error icon.
  final double? sizeIconError;

  /// Creates a [CustomImage] widget.
  const CustomImage(
    this.image, {
    Key? key,
    this.svgTheme,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.color,
    this.borderRadius = BorderRadius.zero,
    this.type,
    this.filterQuality = FilterQuality.medium,
    this.pathNoImage,
    this.onTap,
    this.pathLoading,
    this.childNoImage,
    this.sizeIconError,
    this.childLoading,
    this.elevation = false,
    this.boxShadow = const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        spreadRadius: 5,
        offset: Offset(0, 5),
      ),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: elevation! ? boxShadow : null,
          ),
          child: ClipRRect(
            borderRadius: borderRadius!,
            child: SizedBox(
              height: height,
              width: width,
              child: type == ImageType.file || image.startsWith('/')
                  ? _imageFile()
                  : type == ImageType.asset || image.startsWith('asset')
                      ? _imageAsset()
                      : _imageNetwork(),
            ),
          ),
        ),
      );

  /// Returns the widget for displaying an image loaded from an asset.
  Widget _imageAsset() {
    return image.endsWith('.svg')
        ? SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit!,
            placeholderBuilder: (BuildContext context) => _loading(),
          )
        : Image.asset(
            image,
            color: color,
            height: height,
            width: width,
            filterQuality: filterQuality!,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return _noImage();
            },
          );
  }

  /// Returns the widget for displaying an image loaded from a network URL.
  Widget _imageNetwork() {
    try {
      if (image.endsWith('.svg')) {
        return SvgPicture.network(
          image,
          height: height,
          width: width,
          fit: fit!,
          placeholderBuilder: (BuildContext context) => _loading(),
          theme: svgTheme,
        );
      }

      return Image.network(
        image,
        height: height,
        width: width,
        filterQuality: filterQuality!,
        fit: fit,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _noImage();
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return AnimatedOpacity(
              opacity: 1,
              duration: const Duration(seconds: 3),
              curve: Curves.easeOut,
              child: child,
            );
          }

          return _loading(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          );
        },
      );
    } catch (e) {
      return _noImage();
    }
  }

  /// Returns the widget for displaying a loading indicator.
  Widget _loading({double? value}) {
    try {
      if (childLoading != null) {
        return childLoading!;
      } else if (pathLoading != null) {
        return Image.asset(
          pathLoading!,
          height: height,
          width: width,
          fit: fit,
        );
      } else {
        return Center(
          child: CircularProgressIndicator(
            value: value,
          ),
        );
      }
    } catch (e) {
      return Center(
        child: CircularProgressIndicator(
          value: value,
        ),
      );
    }
  }

  /// Returns the widget for displaying a placeholder when the main image fails to load.
  Widget _noImage() {
    try {
      if (childNoImage != null) {
        return childNoImage!;
      } else if (pathNoImage != null) {
        return Image.asset(
          pathNoImage!,
          fit: fit,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return _iconError();
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            } else {
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
                child: child,
              );
            }
          },
        );
      } else {
        return _iconError();
      }
    } catch (e) {
      return _iconError();
    }
  }

  Widget _iconError() => Icon(Icons.error, size: sizeIconError);

  /// Returns the widget for displaying an image loaded from a file.
  Widget _imageFile() {
    return Image.file(
      File(image),
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      filterQuality: filterQuality ?? FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) {
        return _noImage();
      },
    );
  }
}
