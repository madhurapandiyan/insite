import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/bar_wdiget.dart';

class BarChartWidget extends StatelessWidget {
  final String title;
  final double workingValue;
  final double idleValue;
  final double runningValue;
  final double totalGreatestNumber;
  final double averageGreatestNumber;
  final bool isAverageButtonSelected;
  final List<bool> shouldShowLabel;
  final VoidCallback onTap;
  const BarChartWidget(
      {this.title,
      this.onTap,
      this.idleValue,
      this.shouldShowLabel,
      this.isAverageButtonSelected,
      this.workingValue,
      this.runningValue,
      this.averageGreatestNumber,
      this.totalGreatestNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.26,
      height: MediaQuery.of(context).size.height * 0.21,
      decoration: BoxDecoration(
        color: ship_grey,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: ship_grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    shouldShowLabel[0]
                        ? BarWidget(
                            value: workingValue,
                            color: emerald,
                            onColumnSelected: () {
                              onTap();
                            },
                            averageGreatestNumber: averageGreatestNumber,
                            isAverageButtonSelected: isAverageButtonSelected,
                            totalGreatestNumber: totalGreatestNumber,
                          )
                        : SizedBox(),
                    shouldShowLabel[1]
                        ? BarWidget(
                            value: idleValue,
                            color: burntSienna,
                            onColumnSelected: () {
                              onTap();
                            },
                            averageGreatestNumber: averageGreatestNumber,
                            isAverageButtonSelected: isAverageButtonSelected,
                            totalGreatestNumber: totalGreatestNumber,
                          )
                        : SizedBox(),
                    shouldShowLabel[2]
                        ? BarWidget(
                            value: runningValue,
                            color: creamCan,
                            onColumnSelected: () {
                              onTap();
                            },
                            averageGreatestNumber: averageGreatestNumber,
                            isAverageButtonSelected: isAverageButtonSelected,
                            totalGreatestNumber: totalGreatestNumber,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.26,
              decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                      color: white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
