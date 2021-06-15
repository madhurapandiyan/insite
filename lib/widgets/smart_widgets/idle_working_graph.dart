import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class IdleWorkingGraphWidget extends StatelessWidget {
  final String label;
  final idleLength;
  final workingLength;
  const IdleWorkingGraphWidget({
    Key key,
    @required this.label,
    @required this.idleLength,
    @required this.workingLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            label.length > 10 ? label.substring(0, 7) + '...' : label,
            style: TextStyle(
              color: white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: 2,
          height: 60,
          color: white,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: white.withOpacity(0.5),
              border: Border.all(color: transparent, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: idleLength == 0.0 ? double.infinity : idleLength),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: burntSienna,
                  border: Border.all(color: transparent, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 2,
          height: 60,
          color: white,
        ),
        Expanded(
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: white.withOpacity(0.5),
              border: Border.all(color: transparent, width: 0.0),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  right:
                      workingLength == 0.0 ? double.infinity : workingLength),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: emerald,
                  border: Border.all(color: black, width: 0.0),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}
