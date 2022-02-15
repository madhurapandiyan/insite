import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class SelectedContactListItem extends StatelessWidget {
  final String? email;
  final VoidCallback? voidCallback;
  const SelectedContactListItem({this.email,this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          color: tuna,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: InsiteText(
                    text: email,
                    fontWeight: FontWeight.w700,
                    size: 14,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                  voidCallback!();
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
