import 'package:flutter/material.dart';

class InsiteButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  final double width;
  final double height;
  const InsiteButton(
      {this.title,
      this.width,
      this.onTap,
      this.bgColor,
      this.height,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: bgColor,
        ),
        alignment: Alignment.center,
        height: height != null ? height : null,
        width: width != null ? width : null,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
