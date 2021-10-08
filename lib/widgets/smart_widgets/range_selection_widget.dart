import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class RangeSelectionWidget extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final Function rangeChoice;

  const RangeSelectionWidget({
    Key key,
    @required this.label1,
    @required this.label2,
    @required this.label3,
    @required this.rangeChoice,
  }) : super(key: key);

  @override
  _RangeSelectionWidgetState createState() => _RangeSelectionWidgetState();
}

class _RangeSelectionWidgetState extends State<RangeSelectionWidget> {
  int rangeChoice = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  rangeChoice = 1;
                  widget.rangeChoice(rangeChoice);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color),
                  color: rangeChoice == 1
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: InsiteText(
                    text: widget.label1.toUpperCase(),
                    color: rangeChoice == 1
                        ? white
                        : Theme.of(context).textTheme.bodyText1.color,
                    size: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  rangeChoice = 2;
                  widget.rangeChoice(rangeChoice);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).textTheme.bodyText1.color),
                  color: rangeChoice == 2
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).backgroundColor,
                  borderRadius: widget.label3 == null
                      ? BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4),
                        )
                      : BorderRadius.only(),
                ),
                child: Center(
                  child: InsiteText(
                    text: widget.label2.toUpperCase(),
                    color: rangeChoice == 2
                        ? white
                        : Theme.of(context).textTheme.bodyText1.color,
                    size: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          widget.label3 == null
              ? Container()
              : Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        rangeChoice = 3;
                        widget.rangeChoice(rangeChoice);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: rangeChoice == 3
                            ? Theme.of(context).buttonColor
                            : Theme.of(context).backgroundColor,
                        border: Border.all(
                            color: Theme.of(context).textTheme.bodyText1.color),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: InsiteText(
                          text: widget.label3.toUpperCase(),
                          color: rangeChoice == 3
                              ? white
                              : Theme.of(context).textTheme.bodyText1.color,
                          size: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
