import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class FilterChipItem extends StatelessWidget {
  const FilterChipItem(
      {Key key, @required this.label, this.onClose, this.backgroundColor})
      : super(key: key);

  final String label;
  final VoidCallback onClose;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: transparent, width: 0.0),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label.toUpperCase(),
                style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                onClose();
              },
              child: Icon(
                Icons.close,
                color: white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
