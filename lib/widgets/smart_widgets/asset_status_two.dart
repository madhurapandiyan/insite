import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/asset_status_widget.dart';

class AssetStatus extends StatefulWidget {
  final List<CountDatum> assetStatus;
  final bool isLoading;
  AssetStatus({this.assetStatus, this.isLoading});

  @override
  _AssetStatusState createState() => _AssetStatusState();
}

class _AssetStatusState extends State<AssetStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 235,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                      ],
                    ),
                    Row(
                      children: [
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
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                color: black,
              ),
              widget.isLoading
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: new Row(
                        children: [
                          Expanded(
                            flex: 1,
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
                                            assetStatus: widget.assetStatus,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: new Column(
                              children: [
                                AssetStatusWidget(
                                    emerald,
                                    widget.assetStatus[0].countOf.toUpperCase(),
                                    silver,
                                    "assets/images/arrows.png"),
                                Container(
                                    width: 127.29,
                                    child: Divider(
                                        thickness: 1.0, color: athenGrey)),
                                AssetStatusWidget(
                                    burntSienna,
                                    widget.assetStatus[1].countOf.toUpperCase(),
                                    silver,
                                    "assets/images/arrows.png"),
                                Container(
                                    width: 127.29,
                                    child: Divider(
                                        thickness: 1.0, color: athenGrey)),
                                AssetStatusWidget(
                                    mustard,
                                    widget.assetStatus[2].countOf.toUpperCase(),
                                    silver,
                                    "assets/images/arrows.png"),
                                Container(
                                    width: 127.29,
                                    child: Divider(
                                        thickness: 1.0, color: athenGrey)),
                                AssetStatusWidget(
                                    tabpagecolor,
                                    widget.assetStatus[3].countOf.toUpperCase(),
                                    silver,
                                    "assets/images/arrows.png")
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
