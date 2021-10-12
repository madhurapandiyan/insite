import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

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
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).backgroundColor,
        border: Border.all(
            color: Theme.of(context).textTheme.bodyText1.color, width: 0.0),
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
            InsiteText(
              text: label.toUpperCase(),
              size: 12,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                onClose();
              },
              child: Icon(
                Icons.close,
                color: Theme.of(context).iconTheme.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
