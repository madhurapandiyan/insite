import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class InsiteTitleCountRow extends StatelessWidget {
  const InsiteTitleCountRow(
      {Key? key, this.name, this.count, this.filter, this.onClicked})
      : super(key: key);
  final String? name;
  final String? count;
  final String? filter;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InsiteText(
                text: name == "" ? "Undefined" : name,
                fontWeight: FontWeight.w700,
                size: 12.0,
              ),
              InsiteButton(
                fontSize: 13,
                width: 92,
                textColor: white,
                title: count,
                onTap: () {
                  onClicked!();
                },
              ),
            ],
          ),
          Divider(
            color: thunder,
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
