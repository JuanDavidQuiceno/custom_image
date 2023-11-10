library custom_image;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// enum for image type
///
/// If no type is defined, the default is [ImageType.network].
enum ImageType { file, network, asset }

/// Class for custom image
///
/// [CustomImage] is a widget that can be used to display images from the internet, assets, or files.
class CustomImage extends StatelessWidget {
  /// set onTap for image
  final void Function()? onTap;

  /// path or URL for the image, accepting [String]
  final String image;

  /// set fit for image
  final BoxFit? fit;

  /// set height and width for image
  final double? height;

  /// set height and width for image
  final double? width;

  /// set color for image if you want
  final Color? color;

  /// set borderRadius
  final BorderRadius? borderRadius;

  /// set type image
  final ImageType? type;

  /// set filterQuality for image
  final FilterQuality? filterQuality;

  /// set pathNoImage default asign image
  final String? pathNoImage;

  /// set pathLoading for image local
  final String? pathLoading;
  const CustomImage(
    this.image, {
    Key? key,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.type,
    this.filterQuality,
    this.pathNoImage,
    this.onTap,
    this.pathLoading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => GestureDetector(
        /// if you want to use onTap, you can use it like this
        onTap: onTap,

        /// If you want to apply borders to the corners of the image
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: SizedBox(
            height: height,
            width: width,

            /// check type image
            child: type == ImageType.file
                ? _imageFile()
                : image.startsWith('assets/')
                    ? _imageAsset()
                    : _imageNetwork(),
          ),
        ),
      );

  /// Method for image asset
  ///
  /// check if the image is an asset is .svg or other image types
  Widget _imageAsset() {
    return image.endsWith('.svg')
        ? SvgPicture.asset(
            image,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            placeholderBuilder: (BuildContext context) => _loading(),
          )
        : Image.asset(
            image,
            color: color,
            height: height,
            width: width,
            filterQuality: filterQuality ?? FilterQuality.medium,
            fit: fit ?? BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _noImage();
            },
          );
  }

  /// Method for image network

  Widget _imageNetwork() {
    try {
      /// check if the image ends with .svg or other image types
      /// if the image ends with .svg, it will be displayed using [SvgPicture.network]
      if (image.endsWith('.svg')) {
        return SvgPicture.network(
          image,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          placeholderBuilder: (BuildContext context) => _loading(),
        );
      }

      /// if the image does not end with .svg, it will be displayed using [Image.network]
      return Image.network(
        image,
        height: height,
        width: width,
        filterQuality: filterQuality ?? FilterQuality.medium,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          /// if the image fails to load, it will be displayed using [Image.asset]
          return _noImage();
        },

        /// if the image is loading, it will be displayed using [Image.asset]
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return _loading();
        },
      );
    } catch (e) {
      /// if the image fails to load, it will be displayed using [Image.asset]
      return _noImage();
    }
  }

  /// Method for image loading
  ///
  /// if the image is loading, it will be displayed using [Image.asset]
  /// if the image fails to load, it will be displayed using [CircularProgressIndicator]
  Widget _loading() {
    try {
      return Image.asset(
        pathLoading ?? 'assets/jar-loading.gif',
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
    } catch (e) {
      return const CircularProgressIndicator();
    }
  }

  /// Method for image no image
  ///
  /// if the image is loading, it will be displayed using [Image.asset]

  Widget _noImage() {
    try {
      return Image.asset(
        pathNoImage ?? 'assets/no-image.png',
        fit: fit ?? BoxFit.cover,
      );
    } catch (e) {
      /// TODO: verify if this is the best way to return a Container
      return Container(
        color: Colors.white,
      );
    }
  }

  /// Method for image file
  ///
  /// if path is file, it will be displayed using [Image.file]
  /// if the image fails to load, it will be displayed using [Image.asset]

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
