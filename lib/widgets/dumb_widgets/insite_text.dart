import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InsiteText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final int? maxLines;

  final FontWeight? fontWeight;
  const InsiteText(
      {this.text, this.color, this.fontWeight, this.size, this.maxLines});

  const InsiteText.overflow(
      {this.text, this.color, this.fontWeight, this.size, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        maxLines: maxLines != null ? maxLines : 3,
        style: TextStyle(
          color: color != null
              ? color
              : Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
          fontSize: size,
        ));
  }
}

class InsiteTextAlign extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const InsiteTextAlign(
      {this.text, this.textAlign, this.color, this.fontWeight, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        textAlign: textAlign,
        style: TextStyle(
          color: color != null
              ? color
              : Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
          fontSize: size,
        ));
  }
}

class InsiteTextWithPadding extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  const InsiteTextWithPadding(
      {this.text, this.color, this.fontWeight, this.padding, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(text!,
          style: TextStyle(
            color: color != null
                ? color
                : Theme.of(context).textTheme.bodyText1!.color,
            fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
            fontSize: size,
          )),
    );
  }
}

class InsiteTextOverFlow extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  const InsiteTextOverFlow(
      {this.text, this.overflow, this.color, this.fontWeight, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        overflow: overflow != null ? overflow : null,
        style: TextStyle(
          color: color != null
              ? color
              : Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
          fontSize: size,
        ));
  }
}

class InsiteRichText extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? textColor;
  final VoidCallback? onTap;
  final TextStyle? style;
  const InsiteRichText(
      {this.title, this.content, this.textColor, this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(

            text: title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyText1!.color,
            )),
        TextSpan(
          text: content,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              onTap!();
            },
          style: style != null
              ? style
              : TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: textColor != null
                      ? textColor
                      : Theme.of(context).buttonColor),
        )
      ])),
    );
  }
}
