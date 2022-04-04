import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

import '../../theme/colors.dart';

class DayCheck extends StatelessWidget {
  final String? day;
  final Color? color;
  final Function? onTap;
  final bool? isSelected;
  final bool? checkingAllDays;
  const DayCheck(
      {this.day,
      this.color,
      this.onTap,
      this.isSelected,
      this.checkingAllDays});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        if (checkingAllDays == true) {
          return;
        } else {
          onTap!();
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Theme.of(context).buttonColor),
            color: isSelected == true
                ? Theme.of(context).buttonColor
                : Theme.of(context).cardColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: InsiteText(
                text: day!,
                color:
                    isSelected == true ? white : Theme.of(context).buttonColor,
                //size: day=="fri"?10:null,
              ),
            ),
            Icon(
              Icons.check,
              size: 20,
              color: isSelected == true ? white : Theme.of(context).buttonColor,
            )
          ],
        ),
      ),
    );
  }
}
