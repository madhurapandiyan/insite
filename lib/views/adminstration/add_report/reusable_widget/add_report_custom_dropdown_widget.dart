import 'package:flutter/widgets.dart';
import 'package:insite/theme/colors.dart';

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
        )
      ],
    );
  }
}
