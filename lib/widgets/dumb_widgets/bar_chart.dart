import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/bar_wdiget.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class BarChartWidget extends StatelessWidget {
  final String? title;
  final double? workingValue;
  final double? idleValue;
  final double? runningValue;
  final double? totalGreatestNumber;
  final double? averageGreatestNumber;
  final bool? isAverageButtonSelected;
  final List<bool>? shouldShowLabel;
  final VoidCallback? onTap;
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
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border:
              Border.all(color: Theme.of(context).textTheme.bodyText1!.color!)),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  shouldShowLabel![0]
                      ? Tooltip(
                          message: "$title \n Working :- $workingValue",
                          height: 50,
                          decoration: BoxDecoration(color: cardcolor),
                          padding: EdgeInsets.all(10),
                          child: BarWidget(
                            value: workingValue,
                            color: emerald,
                            onColumnSelected: () {
                              onTap!();
                            },
                            averageGreatestNumber: averageGreatestNumber,
                            isAverageButtonSelected: isAverageButtonSelected,
                            totalGreatestNumber: totalGreatestNumber,
                          ),
                        )
                      : SizedBox(),
                  shouldShowLabel![1]
                      ? Tooltip(
                          message: "$title \n Idle :- $idleValue",
                          height: 50,
                          decoration: BoxDecoration(color: cardcolor),
                          padding: EdgeInsets.all(10),
                          child: BarWidget(
                            value: idleValue,
                            color: burntSienna,
                            onColumnSelected: () {
                              onTap!();
                            },
                            averageGreatestNumber: averageGreatestNumber,
                            isAverageButtonSelected: isAverageButtonSelected,
                            totalGreatestNumber: totalGreatestNumber,
                          ),
                        )
                      : SizedBox(),
                  shouldShowLabel![2]
                      ? Tooltip(
                          message: "$title \n Running :- $runningValue",
                          height: 50,
                          decoration: BoxDecoration(color: cardcolor),
                          padding: EdgeInsets.all(10),
                          child: BarWidget(
                            value: runningValue,
                            color: creamCan,
                            onColumnSelected: () {
                              onTap!();
                            },
                            averageGreatestNumber: averageGreatestNumber,
                            isAverageButtonSelected: isAverageButtonSelected,
                            totalGreatestNumber: totalGreatestNumber,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).textTheme.bodyText1!.color,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.26,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: InsiteText(
                    text: title!.toUpperCase(),
                    size: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
