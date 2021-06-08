import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class FilterChipItem extends StatelessWidget {
  const FilterChipItem({
    Key key,
    @required this.label,
    this.onClose,
  }) : super(key: key);

  final String label;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
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
            Text(label.toUpperCase(),
                style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
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
