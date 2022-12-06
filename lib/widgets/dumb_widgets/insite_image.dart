import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/flavor/flavor.dart';

class InsiteImage extends StatelessWidget {
  final String? path;
  final double? height;
  final double? width;
  const InsiteImage({this.path, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
        image: new ExactAssetImage(path!),
        
        height: height,
        width: width,
        alignment: FractionalOffset.center);
  }
}
