import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

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
        color: white,
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
                  color: rangeChoice == 1 ? tango : cardcolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    topLeft: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.label1.toUpperCase(),
                    style: TextStyle(
                      color: white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
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
                  color: rangeChoice == 2 ? tango : cardcolor,
                  borderRadius: widget.label3 == null
                      ? BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4),
                        )
                      : BorderRadius.only(),
                ),
                child: Center(
                  child: Text(
                    widget.label2.toUpperCase(),
                    style: TextStyle(
                      color: white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
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
                        color: rangeChoice == 3 ? tango : cardcolor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.label3.toUpperCase(),
                          style: TextStyle(
                            color: white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
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
