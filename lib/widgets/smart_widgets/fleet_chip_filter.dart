import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class FleetChipFilter extends StatelessWidget {
  const FleetChipFilter({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 50,
      decoration: BoxDecoration(
        color: cardcolor,
        border: Border.all(color: transparent, width: 0.0),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(color: white, fontSize: 18),
            ),
            Icon(
              Icons.close,
              color: white,
            )
          ],
        ),
      ),
    );
  }
}
