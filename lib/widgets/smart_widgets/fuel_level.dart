import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class FuelLevel extends StatelessWidget {
  const FuelLevel({
    Key key,
    @required this.liquidColor,
    @required this.title,
    @required this.value,
    @required this.lifeTimeFuel,
    @required this.percentage,
    @required this.lastReported,
  }) : super(key: key);

  final Color liquidColor;
  final String title;
  final double value;
  final String lifeTimeFuel;
  final String percentage;
  final String lastReported;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: Theme.of(context).backgroundColor,
        border: Border.all(
            width: 1, color: Theme.of(context).textTheme.bodyText1.color),
        shape: BoxShape.rectangle,
      ),
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
                    thickness: 2,
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
                                valueColor: AlwaysStoppedAnimation(liquidColor),
                                value: value / 100,
                                center: InsiteText(
                                    text: percentage + "%",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    size: 25),
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                borderColor:
                                    Theme.of(context).textTheme.bodyText1.color,
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
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1.color),
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Center(
                child: InsiteText(
                    text: lastReported, fontWeight: FontWeight.bold, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
