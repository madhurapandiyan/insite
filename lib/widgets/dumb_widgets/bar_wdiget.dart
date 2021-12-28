import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class BarWidget extends StatelessWidget {
  final double? value;
  final Color? color;
  final double? totalGreatestNumber;
  final double? averageGreatestNumber;
  final bool? isAverageButtonSelected;
  final VoidCallback? onColumnSelected;

  const BarWidget(
      {this.averageGreatestNumber,
      this.color,
      this.onColumnSelected,
      this.isAverageButtonSelected,
      this.totalGreatestNumber,
      this.value});

  @override
  Widget build(BuildContext context) {
    double totalBarHeight = MediaQuery.of(context).size.height * 0.15;
    return GestureDetector(
      onTap: () {
        onColumnSelected!();
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InsiteText(
                text: value! < 1000
                    ? '${value!.toStringAsFixed(1)}'
                    : '${(value! / 1000).toStringAsFixed(1)}K',
                size: 8,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 15,
              height: (value == 0 ||
                      totalGreatestNumber == 0 ||
                      averageGreatestNumber == 0)
                  ? 0.0
                  // : ((value / widget.assetUtilization.totalMonth.runtimeHours) *
                  //             100) <=
                  //         0
                  //     ? 0.0
                  // : ((totalBarHeight / 100) +
                  //     ((value /
                  //             widget.assetUtilization.totalMonth.runtimeHours) *
                  //         100)),
                  : isAverageButtonSelected!
                      ? ((((value! / averageGreatestNumber!) * 100) /
                              totalBarHeight) *
                          100)
                      : ((((value! / totalGreatestNumber!) * 100) /
                              totalBarHeight) *
                          100),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
