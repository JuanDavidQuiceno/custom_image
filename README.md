<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[![pub package](https://img.shields.io/pub/v/custom_image.svg)](https://pub.dev/packages/custom_image)

## Getting Started

This package is used to make [flutter_svg](https://pub.dev/packages/flutter_svg).

Supports platform compilation for:

- [x] Android
- [x] iOS
- [x] Web
- [x] Windows
- [x] Linux
- [x] MacOS

## Properties :

| Property      | Type                | Description                                                                        |
| ------------- | ------------------- | ---------------------------------------------------------------------------------- |
| image         | **String**          | (required) image path or ulr.                                                      |
| key           | **Key**             | (Optional) Widget key                                                              |
| onTap         | **Function**        | (Optional) Function to execute when the widget is pressed.                         |
| fit           | **BoxFit**          | (Optional) How to inscribe the image into the space allocated during layout.       |
| height        | **double**          | (Optional) The image height.                                                       |
| width         | **double**          | (Optional) The image width.                                                        |
| color         | **Color**           | (Optional) A color to blend with the image.                                        |
| borderRadius  | **BorderRadius**    | (Optional) The image border radius.                                                |
| elevation     | **bool**            | (Optional) The image elevation activate the boxShadow.                             |
| shadowColor   | **List<BoxShadow>** | (Optional) if elevation is true, the shadow default color is black.                |
| type          | **ImageType**       | (Optional) The image type [ImageType.file], [ImageType.network], [ImageType.asset] |
| svgTheme      | **SvgTheme**        | (Optional) The svg theme.                                                          |
| filterQuality | **FilterQuality**   | (Optional) The image filter quality.                                               |
| pathNoImage   | **String**          | (Optional) The image path when the image is not found.                             |
| pathLoading   | **String**          | (Optional) The image path when the image is loading.                               |
| childNoImage  | **Widget**          | (Optional) The widget to be displayed if the main image fails to load.             |
| childLoading  | **Widget**          | (Optional) The widget to be displayed while the main image is loading.             |
| sizeIconError | **double**          | (Optional) The size of the error icon.                                             |

## Contribution

Of course the project is open source, and you can contribute to it [repository link](https://github.com/JuanDavidQuiceno/custom_image).

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributors

<a href="https://github.com/JuanDavidQuiceno/custom_image/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=JuanDavidQuiceno/custom_image" />
</a>
