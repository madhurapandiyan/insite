import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/add_report/fault_code_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class FaultCodeReusableWidget extends StatelessWidget {
  final VoidCallback? voidCallback;
  final FaultCodeModel? faultCodeModel;
  const FaultCodeReusableWidget({this.voidCallback, this.faultCodeModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                voidCallback!();
              },
              child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: faultCodeModel!.isSelected! ? tango : black,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Container(
                    color: faultCodeModel!.isSelected! ? tango : black,
                  )),
            ),
            SizedBox(
              width: 15,
            ),
            InsiteText(
              text: faultCodeModel!.speed,
              fontWeight: FontWeight.w700,
              size: 14,
            )
          ],
        ),
        SizedBox(
          height: 6,
        )
      ],
    );
  }
}
