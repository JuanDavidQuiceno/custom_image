import 'package:custom_image/custom_image.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Image Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Image Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomImage(
                  /// Set the path or URL for the image, accepting [String] types with extensions such as
                  /// [jpg], [jpeg], [png], [gif], [webp], [svg]
                  'https://pbs.twimg.com/media/FnM8-jFWYAIN2X7.jpg',

                  /// set type image
                  /// [ImageType.file],
                  /// [ImageType.network],
                  /// [ImageType.asset]
                  type: ImageType.network,

                  /// if you want to use onTap, you can use it like this
                  onTap: () {
                    /// implement your code here
                  },

                  /// set height and width for image
                  height: 250,
                  width: 250,

                  /// set borderRadius
                  /// [BorderRadius.zero],
                  /// [BorderRadius.circular],
                  /// [BorderRadius.only],
                  /// [BorderRadius.vertical],
                  /// [BorderRadius.horizontal]
                  borderRadius: BorderRadius.circular(50),

                  /// set color for image if you want
                  color: Colors.transparent,

                  /// set fit for image
                  /// [FilterQuality.low],
                  /// [FilterQuality.medium],
                  /// [FilterQuality.high]
                  filterQuality: FilterQuality.high,

                  /// set fit for image
                  /// [BoxFit.contain],
                  /// [BoxFit.cover],
                  /// [BoxFit.fill],
                  /// [BoxFit.fitHeight],
                  /// [BoxFit.fitWidth],
                  /// [BoxFit.none],
                  /// [BoxFit.scaleDown],
                  /// [BoxFit.fitHeight],
                  /// [BoxFit.fitWidth],
                  fit: BoxFit.cover,

                  /// set pathNoImage for a local image
                  pathNoImage: 'assets/no_image.png',

                  /// set pathLoading for a local image
                  pathLoading: 'assets/loading.gif',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
