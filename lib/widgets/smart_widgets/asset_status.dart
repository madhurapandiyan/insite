import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insite/theme/colors.dart';
import 'dart:math';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';

class AssetStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 345.13,
      height: 231.16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: cardcolor)],
        border: Border.all(width: 2.5, color: cardcolor),
        shape: BoxShape.rectangle,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: new Row(
                  children: [
                    SvgPicture.asset("assets/images/arrowdown.svg"),
                    SizedBox(
                      width: 10,
                    ),
                    new Text(
                      "ASSET STATUS",
                      style: new TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Roboto',
                          color: textcolor,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                    ),
                    SizedBox(
                      width: 60.0,
                    ),
                    new Text(
                      'ALL ASSETS',
                      style: new TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Roboto',
                          color: textcolor,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                    ),
                    SizedBox(
                      width: 35.0,
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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: new Row(
                  children: [
                    new Container(
                      width: 160.98,
                      height: 103.74,
                      //color: cardcolor,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.0, color: white),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            // Container of the pie chart
                            child: Container(
                              height: 160.98,
                              width: 103.74,
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: <Widget>[
                                  Transform.rotate(
                                    angle: pi / 1.3,
                                    child: CustomPaint(
                                      child: Center(),
                                      painter: ProgressRings(
                                        completedPercentage: 0.58,
                                        circleWidth: 15.0,
                                        gradient: redGradient,
                                        gradientStartAngle: 0.0,
                                        gradientEndAngle: pi / 2,
                                        progressStartAngle: 1.3,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: pi / 1.3,
                                    child: CustomPaint(
                                      child: Center(),
                                      painter: ProgressRings(
                                        completedPercentage: 0.40,
                                        circleWidth: 15.0,
                                        gradient: yellowGradient,
                                        gradientStartAngle: 0.0,
                                        gradientEndAngle: pi / 2,
                                        progressStartAngle: 1,
                                        lengthToRemove: 1,
                                      ),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: pi / 2.4,
                                    child: CustomPaint(
                                      child: Center(),
                                      painter: ProgressRings(
                                          completedPercentage: 0.45,
                                          circleWidth: 15.0,
                                          gradient: whiteGradient,
                                          gradientStartAngle: 0.0,
                                          gradientEndAngle: pi / 2,
                                          progressStartAngle: 1,
                                          lengthToRemove: 1),
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: pi * 3.2,
                                    child: CustomPaint(
                                      child: Center(),
                                      painter: ProgressRings(
                                        completedPercentage: 0.70,
                                        circleWidth: 15.0,
                                        gradient: greenGradient,
                                        gradientStartAngle: 0.0,
                                        gradientEndAngle: pi / 2,
                                        progressStartAngle: 1.80,
                                        // lengthToRemove: 1
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Column(
                      children: [
                        AssetStatusWidget(emerald, "ASSET OFF", silver,
                            "assets/images/arrows.png"),
                        Container(
                            width: 127.29,
                            child: Divider(thickness: 1.0, color: athenGrey)),
                        AssetStatusWidget(burntSienna, "ASSET ON", silver,
                            "assets/images/arrows.png"),
                        Container(
                            width: 127.29,
                            child: Divider(thickness: 1.0, color: athenGrey)),
                        AssetStatusWidget(mustard, "AWAITING \nFIRST REPORT",
                            silver, "assets/images/arrows.png"),
                        Container(
                            width: 127.29,
                            child: Divider(thickness: 1.0, color: athenGrey)),
                        AssetStatusWidget(tabpagecolor, "NOT REPORTING",
                            silver, "assets/images/arrows.png")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressRings extends CustomPainter {
  /// From 0.0 to 1.0
  final double completedPercentage;
  final double circleWidth;
  final List<Color> gradient;
  final num gradientStartAngle;
  final num gradientEndAngle;
  final double progressStartAngle;
  final double lengthToRemove;

  ProgressRings({
    this.completedPercentage,
    this.circleWidth,
    this.gradient,
    this.gradientStartAngle = 3 * pi / 2,
    this.gradientEndAngle = 4 * pi / 2,
    this.progressStartAngle = 0,
    this.lengthToRemove = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    double arcAngle = 2 * pi * (completedPercentage);

    Rect boundingSquare = Rect.fromCircle(center: center, radius: radius);

    paint(List<Color> colors,
        {double startAngle = 0.0, double endAngle = pi * 2}) {
      final Gradient gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: endAngle,
        colors: colors,
      );

      return Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = circleWidth
        ..shader = gradient.createShader(boundingSquare);
    }

    canvas.drawArc(
      boundingSquare,
      -pi / 2 + progressStartAngle,
      arcAngle - lengthToRemove,
      false,
      paint(
        gradient,
        startAngle: gradientStartAngle,
        endAngle: gradientEndAngle,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter painter) => true;
}
