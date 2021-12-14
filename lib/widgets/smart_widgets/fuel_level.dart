import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class FuelLevel extends StatelessWidget {
  const FuelLevel({
    Key? key,
    required this.liquidColor,
    required this.title,
    required this.value,
    required this.lifeTimeFuel,
    required this.percentage,
    required this.lastReported,
  }) : super(key: key);

  final Color liquidColor;
  final String title;
  final double? value;
  final String lifeTimeFuel;
  final String? percentage;
  final String lastReported;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.38,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Icon(
                      //   Icons.keyboard_arrow_down,
                      //   color: white,
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      InsiteText(
                          text: title.toUpperCase(),
                          fontWeight: FontWeight.bold,
                          size: 15),
                      Expanded(
                        child: Container(),
                      ),
                      // Icon(
                      // Icons.more_vert,
                      // color: white,
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: InsiteText(
                            text: lifeTimeFuel.toUpperCase(),
                            fontWeight: FontWeight.bold,
                            size: 14),
                      ),
                      value != null && percentage != null
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                height: 175,
                                width: 175,
                                child: LiquidCircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(liquidColor),
                                  value: value! / 100,
                                  center: InsiteText(
                                      text: percentage! + "%",
                                      fontWeight: FontWeight.bold,
                                      size: 25),
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  borderColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  borderWidth: 2.0,
                                  direction: Axis.vertical,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 175,
                              width: 175,
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Center(
                  child: InsiteText(
                      text: lastReported,
                      fontWeight: FontWeight.bold,
                      size: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
