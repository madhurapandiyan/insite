import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class AddReportCustomDropDownWidget extends StatelessWidget {
  const AddReportCustomDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 1, color: black),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InsiteText(
                        text: "Select",
                        size: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
