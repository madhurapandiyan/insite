import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
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
        color: tuna,
        border: Border.all(color: black, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(
                      Icons.more_vert,
                      color: white,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: shark,
                    thickness: 2,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        lifeTimeFuel.toUpperCase(),
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: 175,
                        width: 175,
                        child: LiquidCircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(liquidColor),
                          value: value,
                          center: Text(
                            percentage,
                            style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          backgroundColor: tuna,
                          borderColor: shark,
                          borderWidth: 5.0,
                          direction: Axis.vertical,
                        ),
                      ),
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
                color: shark,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Center(
                child: Text(
                  'Last Reported Time: $lastReported'.toUpperCase(),
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
