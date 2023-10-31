library custom_image;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ImageType { file, network }

class CustomImage extends StatelessWidget {
  final void Function()? onTap;
  final String image;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  final ImageType? type;
  final FilterQuality? filterQuality;
  final String? pathNoImage;
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
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          child: SizedBox(
            height: height,
            width: width,
            child: type == ImageType.file
                ? _imageFile()
                : image.startsWith('assets/')
                    ? _imageAsset()
                    : _imageNetwork(),
          ),
        ),
      );

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

  Widget _imageNetwork() {
    try {
      if (image.endsWith('.svg')) {
        return SvgPicture.network(
          image,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          placeholderBuilder: (BuildContext context) => _loading(),
        );
      }
      return Image.network(
        image,
        height: height,
        width: width,
        filterQuality: filterQuality ?? FilterQuality.medium,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _noImage();
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return _loading();
        },
      );
    } catch (e) {
      return _noImage();
    }
  }

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

  Widget _noImage() {
    try {
      return Image.asset(
        pathNoImage ?? 'assets/no-image.png',
        fit: fit ?? BoxFit.cover,
      );
    } catch (e) {
      return Container(
        color: Colors.white,
      );
    }
  }

  Widget _imageFile() {
    return Image.file(
      File(image),
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      filterQuality: filterQuality ?? FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          pathNoImage ?? 'assets/no-image.png',
          fit: fit ?? BoxFit.cover,
        );
      },
    );
  }
}
