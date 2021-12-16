import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class UtilizationLegends extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final Color color1;
  final Color color2;
  final Color color3;
  final Function shouldShowLabel;
  const UtilizationLegends({
    Key? key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.shouldShowLabel,
  }) : super(key: key);

  @override
  _UtilizationLegendsState createState() => _UtilizationLegendsState();
}

class _UtilizationLegendsState extends State<UtilizationLegends> {
  List<bool> shouldShowLabel = [true, true, true];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              setState(() {
                shouldShowLabel[0] = !shouldShowLabel[0];
                if (checkAllFalse()) {
                  shouldShowLabel = [true, true, true];
                }
                widget.shouldShowLabel(shouldShowLabel);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statusWidget(widget.color1, shouldShowLabel[0]),
                InsiteText(
                    text: widget.label1.toUpperCase() + " (Hrs)", size: 8),
              ],
            ),
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              setState(() {
                shouldShowLabel[1] = !shouldShowLabel[1];
                if (checkAllFalse()) {
                  shouldShowLabel = [true, true, true];
                }
                widget.shouldShowLabel(shouldShowLabel);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statusWidget(widget.color2, shouldShowLabel[1]),
                InsiteText(
                  fontWeight: FontWeight.normal,
                  size: 8,
                  text: widget.label2.toUpperCase() + " (Hrs)",
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              setState(() {
                shouldShowLabel[2] = !shouldShowLabel[2];
                if (checkAllFalse()) {
                  shouldShowLabel = [true, true, true];
                }
                widget.shouldShowLabel(shouldShowLabel);
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                statusWidget(widget.color3, shouldShowLabel[2]),
                InsiteText(
                  text: widget.label3.toUpperCase() + " (Hrs)",
                  fontWeight: FontWeight.normal,
                  size: 8,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  bool checkAllFalse() {
    if (!shouldShowLabel[0] && !shouldShowLabel[1] && !shouldShowLabel[2])
      return true;
    return false;
  }

  Container statusWidget(Color color, bool selected) {
    if (selected)
      return Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      );
    else
      return Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: tuna,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
  }
}
