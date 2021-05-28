import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';

class AssetStatusUsage extends StatefulWidget {
  final List<CountDatum> assetStatusUsage;

  AssetStatusUsage({this.assetStatusUsage});
  @override
  _AssetStatusUsageState createState() => _AssetStatusUsageState();
}

class _AssetStatusUsageState extends State<AssetStatusUsage> {
  @override
  Widget build(BuildContext context) {
    //print(widget.AssetOfcount.toString());
    return Container(
      width: 335.13,
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
                      "ASSET USAGE BY HOURS",
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
                    SizedBox(
                      width: 65.0,
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
                    Expanded(
                      flex: 2,
                      child: LayoutBuilder(
                        builder: (context, constraint) => Container(
                            width: 160.98,
                            height: 103.54,
                            decoration: BoxDecoration(
                              color: shark,
                              shape: BoxShape.circle,
                            ),
                            child: Stack(children: [
                              Center(
                                child: SizedBox(
                                  width: constraint.maxWidth * 0.6,
                                  child: CustomPaint(
                                    child: Center(),
                                    foregroundPainter: PieChart(
                                      width: constraint.maxWidth * 0.2,
                                      assetStatus: widget.assetStatusUsage,
                                    ),
                                  ),
                                ),
                              ),
                            ])),
                      ),
                    ),
                    new Column(
                      children: [
                        AssetStatusWidget(emerald, "30 -40 HRS", silver,
                            "assets/images/arrows.png"),
                        Container(
                            width: 127.29,
                            child: Divider(thickness: 1.0, color: athenGrey)),
                        AssetStatusWidget(burntSienna, "20 -30 HRS", silver,
                            "assets/images/arrows.png"),
                        Container(
                            width: 127.29,
                            child: Divider(thickness: 1.0, color: athenGrey)),
                        AssetStatusWidget(mustard, "10-20 HRS", silver,
                            "assets/images/arrows.png"),
                        Container(
                            width: 127.29,
                            child: Divider(thickness: 1.0, color: athenGrey)),
                        AssetStatusWidget(tabpagecolor, "0 -10 HRS", silver,
                            "assets/images/arrows.png")
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

class PieChart extends CustomPainter {
  PieChart({@required this.assetStatus, @required this.width});

  final List<CountDatum> assetStatus;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    assetStatus.forEach((CountDatum) => total += CountDatum.count);
    print('total:$total');

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < assetStatus.length; index++) {
      final currentStatus = assetStatus.elementAt(index);
      print('current:$currentStatus');

      final sweepRadian = (currentStatus.count / total) * (2 * pi);
      print('sweepRadian:$sweepRadian');

      paint.color = kNeumorphicColors.elementAt(index);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );

      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
