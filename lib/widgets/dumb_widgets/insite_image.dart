import 'package:flutter/material.dart';

class InsiteImage extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  const InsiteImage({this.path, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
        image: new ExactAssetImage(path),
        height: height,
        width: width,
        alignment: FractionalOffset.center);
  }
}
