import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class InsiteText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  const InsiteText({this.text, this.color, this.fontWeight, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        ));
  }
}

class InsiteTextOverFlow extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  const InsiteTextOverFlow({this.text, this.color, this.fontWeight, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
        ));
  }
}

class InsiteRichText extends StatelessWidget {
  final String title;
  final String content;
  final Color textColor;
  final VoidCallback onTap;
  const InsiteRichText({this.title, this.content, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: title),
        TextSpan(
          text: content,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              onTap();
            },
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: textColor != null ? textColor : tango),
        )
      ])),
    );
  }
}
