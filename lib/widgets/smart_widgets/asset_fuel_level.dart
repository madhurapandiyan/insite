import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/theme/colors.dart';
import 'dart:math' as math;
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';

class FuelLevel extends StatefulWidget {
  @override
  _FuelLevelState createState() => _FuelLevelState();
}

class _FuelLevelState extends State<FuelLevel>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    final curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCubic);
    animation = Tween<double>(begin: 0.0, end: 3.14).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 345.13,
      height: 221.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: new Row(
            children: [
              SvgPicture.asset("assets/images/arrowdown.svg"),
              SizedBox(
                width: 10,
              ),
              new Text(
                "FUEL LEVEL",
                style: new TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Roboto',
                    color: textcolor,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0),
              ),
              SizedBox(
                width: 210,
              ),
              GestureDetector(
                onTap: () => print("button is tapped"),
                child: SvgPicture.asset(
                  "assets/images/menu.svg",
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          color: black,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomPaint(
                  painter: ProgressArc(null, black, true),
                ),
                CustomPaint(
                  painter: ProgressArc(animation.value, Colors.white, false),
                ),
              ],
            ),
            SizedBox(
              width: 200,
            ),
            Column(
              children: [
                AssetStatusWidget(
                    burntSienna, "< 25 % ", silver, "assets/images/arrows.png"),
                Container(
                    width: 127.29,
                    child: Divider(thickness: 1.0, color: athenGrey)),
                AssetStatusWidget(
                    lightRose, "< 50 %", silver, "assets/images/arrows.png"),
                Container(
                    width: 127.29,
                    child: Divider(thickness: 1.0, color: athenGrey)),
                AssetStatusWidget(
                    mustard, "< 75 %", silver, "assets/images/arrows.png"),
                Container(
                    width: 127.29,
                    child: Divider(thickness: 1.0, color: athenGrey)),
                AssetStatusWidget(
                    emerald, "<= 100 %", silver, "assets/images/arrows.png")
              ],
            )
          ],
        ),
      ]),
    );
  }
}

class ProgressArc extends CustomPainter {
  bool isBackground;
  double arc;
  Color progressColor;

  ProgressArc(this.arc, this.progressColor, this.isBackground);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(170 - 90 * 1.3, 40, 165, 163);

    final startAngle = math.pi;
    final sweepAngle = math.pi;
    final useCenter = false;

    final paint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    if (!isBackground) {
      paint.shader = gradient.createShader(rect);
    }

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
