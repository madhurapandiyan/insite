import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insite/core/models/asset_status.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class FaultWidget extends StatefulWidget {
  final Count data;
  final ScreenType screenType;
  //final String containerText;
  final String level;
  //final String buttonText;
  final Color buttonColor;
  final VoidCallback onSelected;
  FaultWidget(
      {this.data,
      this.level,
      this.buttonColor,
      this.onSelected,
      this.screenType});

  @override
  _FaultWidgetState createState() => _FaultWidgetState();
}

class _FaultWidgetState extends State<FaultWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          widget.onSelected();
        },
        child: Row(
          children: [
            widget.screenType == ScreenType.DASHBOARD
                ? InsiteButton(
                    textColor: Colors.white,
                    padding: EdgeInsets.all(4),
                    title: widget.data.assetCount.toString(),
                    width: 51,
                    height: 27,
                  )
                : Container(),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 1,
              child: InsiteText(
                  text: widget.level, fontWeight: FontWeight.w700, size: 14.0),
            ),
            InsiteButton(
              bgColor: widget.buttonColor,
              title: widget.data.faultCount.toString(),
              textColor: darkGrey,
              width: 61,
              height: 28,
            )
          ],
        ),
      ),
      Container(child: Divider(thickness: 1.0, color: black))
    ]);
  }
}
